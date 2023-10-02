part of 'home_cubit.dart';

class HomeState extends Equatable {
  final String message;
  final LoadingState loadingState;
  final GetBannersState getBannersState;
  final int currentShownImgIndex;
  final List<String> imgList;
  final List<String> categories;
  final GetBannerResponse? getBannerResponse;

  const HomeState(
      {this.message = '',
      this.loadingState = LoadingState.init,
        this.getBannersState = GetBannersState.loading,
      this.currentShownImgIndex = 0,
      this.imgList = AppImages.carouselImages,
      this.categories = const[
        "Food",
        "Tech",
        "Fashion",
        "Gaming",
        "Miscellaneous",
      ],
      this.getBannerResponse,});

  HomeState copyWith({
    String? message,
    LoadingState? loadingState,
    int? currentShownImgIndex,
    List<String>? imgList,
    List<String>? categories,
    GetBannerResponse? getBannerResponse,
    GetBannersState? getBannersState,
  }) {
    return HomeState(
        loadingState: loadingState ?? this.loadingState,
        message: message ?? this.message,
        currentShownImgIndex: currentShownImgIndex ?? this.currentShownImgIndex,
        imgList: imgList ?? this.imgList,
        categories: categories ?? this.categories,
        getBannerResponse: getBannerResponse ?? this.getBannerResponse,
        getBannersState: getBannersState ?? this.getBannersState,);
  }

  @override
  List<Object?> get props => [
        currentShownImgIndex,
        loadingState,
        message,
        imgList,
        categories,
    getBannerResponse,
    getBannersState,
      ];
}
