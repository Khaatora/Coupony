import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/constants/app_images.dart';
import 'package:maslaha/core/home_layout/view_model/home_layout_cubit.dart';
import 'package:maslaha/core/utils/enums/apis/get_banners_state.dart';
import 'package:maslaha/core/utils/enums/loading_enums.dart';

import '../../core/services/services_locator.dart';
import '../model/get_banner_response.dart';
import '../repository/i_home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  IHomeRepository homeRepository;

  HomeCubit(this.homeRepository) : super(const HomeState());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  void setCurrentImgIndex(int index) {
    if(isClosed)return;
    emit(state.copyWith(currentShownImgIndex: index));
  }

  Future<void> getBanners() async {
    final result = await homeRepository.getBannerData(
        GetBannerParams(sl<HomeLayoutCubit>().state.userData!.region));
    if(isClosed)return;
    result.fold(
        (l) => emit(state.copyWith(
            getBannersState: GetBannersState.error, message: l.message, loadingState: LoadingState.error)),
        (r) => emit(state.copyWith(
              getBannersState: GetBannersState.loaded,
              getBannerResponse: r,
            )));
  }

}
