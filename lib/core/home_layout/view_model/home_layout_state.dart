part of 'home_layout_cubit.dart';

class HomeLayoutState extends Equatable {
  final LoadingState loadingState;
  final BottomNavScreen bottomNavScreen;
  final double bottomNavBarItemWidth;
  final double bottomNavBarItemBorderWidth;
  final int currentIndex;
  final String message;
  final GetDataCampaignsResponse? getDataCampaignsResponse;
  final GetCouponResponse? getCouponResponse;
  //TODO : change userData back to nullable
  final UserData userData;
  final List<ListCategory>? categories;
  final bool showLoadingScreen;
  final GetCouponState getCouponState;
  final GetFavoritesState getFavoritesState;
  final CreateOrRemoveFavoriteState createOrRemoveFavoriteState;
  final SearchState searchState;
  final String storeName;
  final List<Campaign> searchMatches;

  const HomeLayoutState({
    this.loadingState = LoadingState.init,
    this.bottomNavScreen = BottomNavScreen.Home,
    this.currentIndex = 0,
    this.message = "",
    this.bottomNavBarItemWidth = 42.0,
    this.bottomNavBarItemBorderWidth = 5.0,
    this.getDataCampaignsResponse,
    //TODO: change userData back to null
    this.userData = const UserData(lang: "English", region: "GCC", token: ""),
    this.categories = const [
      ListCategory(
        id: 1,
        categoryName: "Food",
      ),
      ListCategory(
        id: 2,
        categoryName: "Tech",
      ),
      ListCategory(
        id: 3,
        categoryName: "Fashion",
      ),
      ListCategory(
        id: 4,
        categoryName: "Gaming",
      ),
      ListCategory(
        id: 5,
        categoryName: "Miscellaneous",
      ),
    ],
    this.getCouponResponse,
    this.showLoadingScreen = false,
    this.getCouponState = GetCouponState.loading,
    this.getFavoritesState = GetFavoritesState.loading,
    this.createOrRemoveFavoriteState = CreateOrRemoveFavoriteState.init,
    this.searchState = SearchState.init,
    this.storeName = "coupons",
    this.searchMatches = const [],
  });

  HomeLayoutState copyWith(
      {LoadingState? loadingState,
      BottomNavScreen? bottomNavScreen,
      int? currentIndex,
      String? message,
      GetDataCampaignsResponse? getDataCampaignsResponse,
      List<ListCategory>? categories,
      UserData? userData,
      GetCouponResponse? getCouponResponse,
      bool? showLoadingScreen,
      GetCouponState? getCouponState,
      GetFavoritesState? getFavoritesState,
        CreateOrRemoveFavoriteState? createOrRemoveFavoriteState,
      SearchState? searchState,
      String? storeName,
      List<Campaign>? searchMatches}) {
    return HomeLayoutState(
      loadingState: loadingState ?? this.loadingState,
      bottomNavScreen: bottomNavScreen ?? this.bottomNavScreen,
      currentIndex: currentIndex ?? this.currentIndex,
      message: message ?? this.message,
      getDataCampaignsResponse:
          getDataCampaignsResponse ?? this.getDataCampaignsResponse,
      categories: categories ?? this.categories,
      userData: userData ?? this.userData,
      getCouponResponse: getCouponResponse ?? this.getCouponResponse,
      showLoadingScreen: showLoadingScreen ?? this.showLoadingScreen,
      getCouponState: getCouponState ?? this.getCouponState,
      searchState: searchState ?? this.searchState,
      searchMatches: searchMatches ?? this.searchMatches,
      storeName: storeName ?? this.storeName,
      getFavoritesState: getFavoritesState ?? this.getFavoritesState,
      createOrRemoveFavoriteState: createOrRemoveFavoriteState ?? this.createOrRemoveFavoriteState,
    );
  }

  @override
  List<Object?> get props => [
        loadingState,
        bottomNavScreen,
        currentIndex,
        message,
        getDataCampaignsResponse,
        getCouponResponse,
        userData,
        categories,
        showLoadingScreen,
        getCouponState,
        searchState,
        storeName,
        searchMatches,
        getFavoritesState,
    createOrRemoveFavoriteState,
      ];
}

class UserData {
  final String lang;
  final String region;
  final String token;

  const UserData({
    required this.lang,
    required this.region,
    required this.token,
  });
}

class ListCategory {
  final int id;
  final String categoryName;

  const ListCategory({required this.id, this.categoryName = "Food"});
}
