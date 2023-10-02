import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/global/localization.dart';
import 'package:maslaha/core/home_layout/view_model/home_layout_cubit.dart';
import 'package:maslaha/core/utils/enums/loading_enums.dart';
import 'package:maslaha/core/utils/enums/search_state_enums.dart';
import '../../core/home_layout/model/get_data_campaigns_response.dart';
import '../../core/services/services_locator.dart';

part 'coupons_state.dart';

class CouponsCubit extends Cubit<CouponsState> {
  CouponsCubit()
      : super(const CouponsState(
            campaignsList: [], filterList: [], searchList: []));

  static CouponsCubit get(context) => BlocProvider.of<CouponsCubit>(context);

  void updateTitle(String title) {
    if (isClosed) return;
    emit(state.copyWith(title: title));
  }

  void initCubit() {
    final HomeLayoutState homeLayoutCubitState = sl<HomeLayoutCubit>().state;
    loadList(homeLayoutCubitState.getDataCampaignsResponse!);
    if (homeLayoutCubitState.searchState == SearchState.loaded) {
      showSearchResults(
          homeLayoutCubitState.searchMatches, homeLayoutCubitState.storeName);
      sl<HomeLayoutCubit>().clearSearchData();
    }
  }

  void loadList(GetDataCampaignsResponse campaigns) {
    if (state.isSearch || state.campaignsList.isNotEmpty || state.isFilter) return;
    if (isClosed) return;
    emit(state.copyWith(loadingState: LoadingState.loading));
    final tempList = _getList(campaigns);
    if (isClosed) return;
    emit(state.copyWith(
        loadingState: LoadingState.loaded,
        campaignsList: tempList,
        isFilter: false,
        isSearch: false));
  }

  //TODO: change algorithm
  List<Campaign> _getList(GetDataCampaignsResponse campaigns) {
    log("loading list");
    // final List<Data> tempCampaigns = campaigns.data;
    // final List<Logo> tempLogos = campaigns.logo;
    // final List<Campaign> tempList = [];
    // for (int i = 0; i < tempLogos.length; i++) {
    //   log("campaigns: ${tempCampaigns[i].name}, logos: ${tempLogos[i].name}");
    //   final tmpLogo = tempLogos[i];
    //   tempList.add(Campaign(
    //       data: tempCampaigns.firstWhere((campaign) =>
    //           campaign.name.toLowerCase() == tmpLogo.name.toLowerCase()),
    //       logo: tmpLogo));
    //   log(tempList[i].data.name);
    // }
    return campaigns.campaigns;
  }

  void showSearchResults(List<Campaign> matchedResults, String title) {
    if (isClosed) return;
    emit(state.copyWith(loadingState: LoadingState.loading));
    log("loading searched list");
    emit(state.copyWith(
      searchList: matchedResults,
      loadingState: LoadingState.loaded,
      title: title,
      isSearch: true,
      isFilter: false,
    ));
  }

  List<Campaign> _getAndFilterList(
      GetDataCampaignsResponse campaigns, String category) {
    final List<Campaign> tempList = [];
    if (state.campaignsList.isNotEmpty) {
      log("filtering list..");
      tempList.addAll(state.campaignsList
          .where((element) => element.data.category == category)
          .toList());
    } else {
      log("getting and filtering list..");
      // final List<Data> tempCampaigns = campaigns.data
      //     .where((element) => element.category == category)
      //     .toList();
      // final List<Logo> tempLogos = campaigns.logo;
      // for (int i = 0; i < tempLogos.length; i++) {
      //   final tmpLogo = tempLogos[i];
      //   if (tempCampaigns.any((element) => element.name.toLowerCase() == tmpLogo.name.toLowerCase())) {
      //     tempList.add(Campaign(
      //         data: tempCampaigns.firstWhere((campaign) =>
      //             campaign.name.toLowerCase() == tmpLogo.name.toLowerCase()),
      //         logo: tmpLogo));
      //     log(tempList[i].data.name);
      //   }
      // }
      tempList.addAll(campaigns.campaigns.where((element) => element.data.category.toLowerCase() == category.toLowerCase()));
    }
    return tempList;
  }

  void filterAndShowResults(
      GetDataCampaignsResponse campaigns, String category) {
    if (isClosed) return;
    emit(state.copyWith(
      loadingState: LoadingState.loading,
      isFilter: true,
      isSearch: false,
    ));
    final List<Campaign> tempList = _getAndFilterList(campaigns, category);
    if (isClosed) return;
    emit(state.copyWith(
      loadingState: LoadingState.loaded,
      title: category,
      filterList: tempList,
    ));
  }

  void unfilter() {
    log("unfiltering..");
    if (isClosed) return;
    emit(state.copyWith(
        loadingState: LoadingState.loaded,
        isFilter: false,
        title: EnglishLocalization.coupons));
  }

  @override
  Future<void> close() {
    sl.unregister<CouponsCubit>();
    return super.close();
  }
}
