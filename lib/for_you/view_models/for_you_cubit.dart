import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maslaha/core/utils/enums/loading_enums.dart';

import '../../core/home_layout/model/get_data_campaigns_response.dart';
import '../repository/i_for_you_repository.dart';

part 'for_you_state.dart';

class ForYouCubit extends Cubit<ForYouState> {

  final IForYouRepository forYouRepository;

  ForYouCubit(this.forYouRepository) : super(const ForYouState(campaigns: []));

  Future<void> getRecommendations(GetDataCampaignsResponse campaigns,String region, String token) async {

    final result = await forYouRepository.getRecommendations(GetRecommendationsParams(region), token);
    if(isClosed)return;
    result.fold((l) => emit(state.copyWith(
      message: l.message,
      loadingState: LoadingState.error,
    )), (r) {
      emit(state.copyWith(
        loadingState: LoadingState.loaded,
        campaigns: _filterByCampaignIds(campaigns, r.data),
      ));
    });
  }

  List<Campaign> _filterByCampaignIds(GetDataCampaignsResponse campaigns, List<int> campaignIds){
    return campaigns.campaigns.where((element) => campaignIds.contains(element.data.campaignId)).toList();
  }
}
