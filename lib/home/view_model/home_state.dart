part of 'home_cubit.dart';

class HomeState extends Equatable {
  final String message;
  final LoadingState loadingState;
  final int currentShownImgIndex;
  final List<String> imgList;
  final List<String> categories;

  const HomeState(
      {this.message = '',
      this.loadingState = LoadingState.init,
      this.currentShownImgIndex = 0,
      this.imgList = AppImages.carouselImages,
      this.categories = const[
        "Food",
        "Tech",
        "Fashion",
        "Gaming",
        "Miscellaneous",
      ]});

  HomeState copyWith({
    String? message,
    LoadingState? loadingState,
    int? currentShownImgIndex,
    List<String>? imgList,
    List<String>? categories,
  }) {
    return HomeState(
        loadingState: loadingState ?? this.loadingState,
        message: message ?? this.message,
        currentShownImgIndex: currentShownImgIndex ?? this.currentShownImgIndex,
        imgList: imgList ?? this.imgList,
        categories: categories ?? this.categories);
  }

  @override
  List<Object> get props => [
        currentShownImgIndex,
        loadingState,
        message,
        imgList,
        categories,
      ];
}
