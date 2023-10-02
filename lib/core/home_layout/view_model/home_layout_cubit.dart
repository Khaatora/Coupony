import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/global/localization.dart';
import 'package:maslaha/core/home_layout/model/favorites_response.dart';
import 'package:maslaha/core/home_layout/model/get_coupon_response.dart';
import 'package:maslaha/core/utils/enums/apis/get_favorites_state.dart';
import 'package:maslaha/core/utils/enums/create_or_remove_favorite_state.dart';
import 'package:maslaha/core/utils/enums/search_state_enums.dart';
import 'package:maslaha/coupon/view_models/coupons_cubit.dart';
import 'package:maslaha/coupon/views/coupons_screen.dart';
import 'package:maslaha/for_you/views/for_you_screen.dart';
import '../../../favorites/views/favorites_screen.dart';
import '../../../home/view/home_screen.dart';
import '../../services/services_locator.dart';
import '../../utils/enums/apis/get_coupons_state.dart';
import '../../utils/enums/bottom_nav_enums.dart';
import '../../utils/enums/loading_enums.dart';
import '../model/get_data_campaigns_response.dart';
import '../repository/i_home_layout_repository.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  IHomeLayoutRepository homeLayoutRepository;

  HomeLayoutCubit(this.homeLayoutRepository) : super(const HomeLayoutState());

  List<Widget> get pages => [
        const HomeScreen(),
        const CouponsScreen(),
        const FavoritesScreen(),
        const ForYouScreen(),
      ];

  static HomeLayoutCubit get(context) =>
      BlocProvider.of<HomeLayoutCubit>(context);

  void updateIndex(int index) {
    if (state.loadingState == LoadingState.error) {
      initData();
    }
    if (index == 1) {
      if (!sl.isRegistered<CouponsCubit>()) {
        sl.registerLazySingleton<CouponsCubit>(() => CouponsCubit());
      }
    }
    if (isClosed) return;
    emit(state.copyWith(currentIndex: index, searchState: SearchState.init));
  }

  Future<void> initiatePeriodicInternetConnectionCheck() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (state.getDataCampaignsResponse == null) {
        return;
      }
      final result = await homeLayoutRepository.checkInternetConnection();
      if (isClosed) {
        timer.cancel();
        return;
      }
      result.fold(
          (l) => emit(state.copyWith(
                loadingState: LoadingState.error,
                message: l.message,
              )),
          (r) => emit(state.copyWith(loadingState: LoadingState.loaded)));
    });
  }

  Future<void> initData() async {
    if (isClosed) return;
    emit(state.copyWith(loadingState: LoadingState.loading));
    //todo: uncomment code on release
    // final getUserDataResult = await homeLayoutRepository.getCachedData();
    // if (isClosed) return;
    // getUserDataResult.fold((l) {
    //   emit(state.copyWith(
    //     loadingState: LoadingState.error,
    //   ));
    // }
    // , (r) {
    //   emit(state.copyWith(
    //       userData: UserData(
    //           token: r.token,
    //           lang: r.userSettings.lang,
    //           region: r.userSettings.region)));
    // });
    if (state.loadingState == LoadingState.error) {
      return;
    }
    final getCategoriesResult = await homeLayoutRepository
        .getCategoriesData(state.userData.token ?? "");
    if (isClosed) return;
    getCategoriesResult.fold((l) {
      if(l.message == state.message && state.loadingState == LoadingState.error) return;
      emit(
          state.copyWith(loadingState: LoadingState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(categories: r.categories));
    });
    if (state.loadingState == LoadingState.error) {
      return;
    }
    final getCampaignResult = await homeLayoutRepository.getDataCampaigns(
        GetCampaignsParams(state.userData!.region),
        state.userData?.token ?? "");
    if (isClosed) return;
    getCampaignResult.fold((l) {
      emit(
          state.copyWith(loadingState: LoadingState.error, message: l.message));
    }, (campaigns) async {
      if (!sl.isRegistered<CouponsCubit>()) {
        sl.registerSingleton<CouponsCubit>(CouponsCubit());
      }
      final getFavoritesResult = await homeLayoutRepository.getFavorites(
          const GetFavoritesParams(), state.userData?.token ?? "");
      if (isClosed) return;
      getFavoritesResult.fold((l) {
        emit(state.copyWith(
            loadingState: LoadingState.loaded,
            message: l.message,
            getDataCampaignsResponse: campaigns,
            getFavoritesState: GetFavoritesState.error));
        Timer.periodic(const Duration(seconds: 1), (timer) async {
          if(state.loadingState == LoadingState.error) return;
          if (isClosed || state.getFavoritesState == GetFavoritesState.loaded) {
            log("Favorites timer Cancelled");
            timer.cancel();
            return;
          }
          log("Favorites timer working");
          final getFavoritesResult = await homeLayoutRepository.getFavorites(
              const GetFavoritesParams(), state.userData?.token ?? "");
          if (isClosed) {
            timer.cancel();
            return;
          }
          getFavoritesResult.fold((l) {}, (r) {
            _updateFavorites(campaigns, r);
            timer.cancel();
            if (isClosed) {
              timer.cancel();
              return;
            }
            emit(state.copyWith(
              getDataCampaignsResponse: campaigns,
              getFavoritesState: GetFavoritesState.loaded,
            ));
          });
        });
      }, (favorites) {
        _updateFavorites(campaigns, favorites);
        if (isClosed) return;
        emit(state.copyWith(
          loadingState: LoadingState.loaded,
          getFavoritesState: GetFavoritesState.loaded,
          getDataCampaignsResponse: campaigns
        ));
      });
    });
  }

  Future<void> getCoupon(String channel, int campaignId) async {
    emit(state.copyWith(showLoadingScreen: true));
    final result = await homeLayoutRepository.getCouponData(
        GetCouponParams(campaignId, channel), state.userData?.token ?? "");
    if (isClosed) return;
    result.fold(
        (l) => emit(state.copyWith(
            getCouponState: GetCouponState.error,
            message: l.message,
            showLoadingScreen: false)), (r) {
      emit(state.copyWith(
          getCouponState: GetCouponState.loaded,
          getCouponResponse: r,
          showLoadingScreen: false));
    });
  }

  Future<void> createOrder(String code) async {
    final result = await homeLayoutRepository.createOrder(
        CreateOrderParams(code), state.userData?.token ?? "");
    if (isClosed) return;
    // result.fold(
    //         (l) => emit(state.copyWith(
    //         getCouponState: GetCouponState.error, message: l.message, showLoadingScreen: false)),
    //         (r) {
    //       emit(state.copyWith(
    //           showLoadingScreen: false
    //       ));
    //     });
  }

  Future<void> search(String storeName) async {
    if (isClosed) return;
    emit(state.copyWith(
      searchState: SearchState.loading,
    ));
    if (storeName.length < 2) {
      emit(state.copyWith(
          searchState: SearchState.error,
          message: EnglishLocalization.writeAtleastTwoCharacters));
      return;
    }
    emit(state.copyWith(showLoadingScreen: true));
    final result = await homeLayoutRepository.checkInternetConnection();
    result.fold((l) {
      if (isClosed) return;
      emit(state.copyWith(
          loadingState: LoadingState.error,
          message: l.message,
          showLoadingScreen: false));
    }, (r) {
      if (state.getDataCampaignsResponse == null) {
        if (isClosed) return;
        emit(state.copyWith(
            loadingState: LoadingState.error, showLoadingScreen: false));
      } else {
        final List<Campaign> matchedStores = state
            .getDataCampaignsResponse!.campaigns
            .where((element) => element.data.name
                .toLowerCase()
                .contains(storeName.toLowerCase()))
            .toList();
        log("matchedStores length : ${matchedStores.length}");
        if (matchedStores.isEmpty) {
          if (isClosed) return;
          emit(state.copyWith(
              loadingState: LoadingState.loaded,
              showLoadingScreen: false,
              searchState: SearchState.error,
              message: EnglishLocalization.noMatchedStore));
        } else {
          if (!sl.isRegistered<CouponsCubit>()) {
            sl.registerSingleton<CouponsCubit>(CouponsCubit());
          }
          if (state.currentIndex == 1) {
            sl<CouponsCubit>().showSearchResults(matchedStores, storeName);
          }
          if (isClosed) return;
          emit(state.copyWith(
              searchState: SearchState.loaded,
              loadingState: LoadingState.loaded,
              showLoadingScreen: false,
              currentIndex: 1,
              storeName: storeName,
              searchMatches: matchedStores));
        }
      }
    });
  }

  Future<void> createFavorite(int campaignId) async {
    if (isClosed) return;
    emit(state.copyWith(
        createOrRemoveFavoriteState: CreateOrRemoveFavoriteState.loading,
        getFavoritesState: GetFavoritesState.loading));
    final result = await homeLayoutRepository.createFavorites(
        CreateFavoriteParams(
          campaignId: campaignId,
        ),
        state.userData?.token ?? "");
    if (isClosed) return;
    result.fold(
        (l) => emit(state.copyWith(
              createOrRemoveFavoriteState: CreateOrRemoveFavoriteState.error,
              getFavoritesState: GetFavoritesState.loaded,
              message: l.message,
            )), (r) {
      _updateFavorite(state.getDataCampaignsResponse!, campaignId);
      emit(state.copyWith(
        createOrRemoveFavoriteState: CreateOrRemoveFavoriteState.created,
        getFavoritesState: GetFavoritesState.loaded,
      ));
    });
  }

  Future<void> removeFavorite(int campaignId) async {
    if (isClosed) return;
    emit(state.copyWith(
        createOrRemoveFavoriteState: CreateOrRemoveFavoriteState.loading));
    final result = await homeLayoutRepository.removeFavorites(
        RemoveFavoriteParams(
          campaignId: campaignId,
        ),
        state.userData?.token ?? "");
    if (isClosed) return;
    result.fold(
        (l) => emit(state.copyWith(
              createOrRemoveFavoriteState: CreateOrRemoveFavoriteState.error,
              message: l.message,
            )), (r) {
      _updateFavorite(state.getDataCampaignsResponse!, campaignId);
      emit(state.copyWith(
        createOrRemoveFavoriteState: CreateOrRemoveFavoriteState.removed,
      ));
    });
  }

  void switchAndFilter(String category) {
    if (!sl.isRegistered<CouponsCubit>()) {
      sl.registerSingleton<CouponsCubit>(CouponsCubit());
    }
    if (isClosed) return;
    emit(state.copyWith(currentIndex: 1));
    sl<CouponsCubit>()
        .filterAndShowResults(state.getDataCampaignsResponse!, category);
  }

  void clearCouponData() {
    if (isClosed) return;
    emit(state.copyWith(
      getCouponState: GetCouponState.loading,
      getCouponResponse: null,
    ));
  }

  void clearSearchData() {
    if (isClosed) return;
    emit(state.copyWith(
      storeName: EnglishLocalization.coupons,
      searchMatches: [],
      searchState: SearchState.init,
    ));
  }

  void _updateFavorites(
      GetDataCampaignsResponse campaigns, GetFavoritesResponse favorites) {
    campaigns.campaigns.map((campaign) {
      final int tempIndex = favorites.favorites.indexWhere(
          (favorite) => favorite.campaignId == campaign.data.campaignId);
      if (tempIndex != -1) {
        campaigns.campaigns[tempIndex] = Campaign(
            data: Data(
                campaignId: campaign.data.campaignId,
                clicksNo: campaign.data.clicksNo,
                category: campaign.data.category,
                link: campaign.data.link,
                name: campaign.data.name,
                rate: campaign.data.rate,
                region: campaign.data.region,
                startDate: campaign.data.startDate,
                isFav: true),
            logo: campaign.logo);
      }
    }).toList();
    log("fav :${campaigns.campaigns[0]!.data.isFav}");
  }

  void _updateFavorite(GetDataCampaignsResponse campaigns, int campaignId) {
    int campaignIndex = campaigns.campaigns
        .indexWhere((campaign) => campaign.data.campaignId == campaignId);
    campaigns.campaigns[campaignIndex] = Campaign(
      data: Data(
          campaignId: campaigns.campaigns[campaignIndex].data.campaignId,
          clicksNo: campaigns.campaigns[campaignIndex].data.clicksNo,
          category: campaigns.campaigns[campaignIndex].data.category,
          link: campaigns.campaigns[campaignIndex].data.link,
          name: campaigns.campaigns[campaignIndex].data.name,
          rate: campaigns.campaigns[campaignIndex].data.rate,
          region: campaigns.campaigns[campaignIndex].data.region,
          startDate: campaigns.campaigns[campaignIndex].data.startDate,
          isFav: !campaigns.campaigns[campaignIndex].data.isFav),
      logo: campaigns.campaigns[campaignIndex].logo,
    );
  }

  @override
  Future<void> close() {
    sl.unregister<HomeLayoutCubit>();
    sl.unregister<CouponsCubit>();
    return super.close();
  }
}
