part of 'home_layout_cubit.dart';

class HomeLayoutState extends Equatable {

  final LoadingState loadingState;
  final BottomNavScreen bottomNavScreen;
  final double bottomNavBarItemWidth;
  final double bottomNavBarItemBorderWidth;
  final int currentIndex;
  final String message;
  final GetDataCampaignsResponse? getDataCampaignsResponse;
  final List<String> categories;

  const HomeLayoutState({
    this.loadingState = LoadingState.init,
    this.bottomNavScreen = BottomNavScreen.Home,
    this.currentIndex = 0,
    this.message = "",
    this.bottomNavBarItemWidth = 42.0,
    this.bottomNavBarItemBorderWidth = 5.0,
    this.getDataCampaignsResponse,
    this.categories = const[
      "Food",
      "Tech",
      "Fashion",
      "Gaming",
      "Miscellaneous",
    ]
  });

  HomeLayoutState copyWith({
    LoadingState? loadingState,
    BottomNavScreen? bottomNavScreen,
    int? currentIndex,
    String? message,
    GetDataCampaignsResponse? getDataCampaignsResponse,
    List<String>? categories,
  }) {
    return HomeLayoutState(
      loadingState: loadingState ?? this.loadingState,
      bottomNavScreen: bottomNavScreen ?? this.bottomNavScreen,
      currentIndex: currentIndex ?? this.currentIndex,
      message: message ?? this.message,
      getDataCampaignsResponse: getDataCampaignsResponse ?? this.getDataCampaignsResponse,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
    loadingState,
    bottomNavScreen,
    currentIndex,
    message,
    getDataCampaignsResponse,
    categories,
  ];
}
