part of 'coupons_cubit.dart';

class CouponsState extends Equatable {
  final String title;
  final LoadingState loadingState;
  final bool isSearch;
  final List<Campaign> campaignsList;
  final List<Campaign> searchList;
  final List<Campaign> filterList;
  final bool isFilter;

  const CouponsState(
      {this.title = "Coupons",
      required this.campaignsList,
      required this.searchList,
      required this.filterList,
      this.loadingState = LoadingState.loading,
      this.isSearch = false,
      this.isFilter = false});

  CouponsState copyWith(
      {String? title,
      List<Campaign>? campaignsList,
      List<Campaign>? searchList,
      List<Campaign>? filterList,
      LoadingState? loadingState,
      bool? isSearch,
      bool? isFilter}) {
    return CouponsState(
      title: title ?? this.title,
      campaignsList: campaignsList ?? this.campaignsList,
      searchList: searchList ?? this.searchList,
      filterList: filterList ?? this.filterList,
      loadingState: loadingState ?? this.loadingState,
      isSearch: isSearch ?? this.isSearch,
      isFilter: isFilter ?? this.isFilter,
    );
  }

  @override
  List<Object?> get props => [
        title,
        campaignsList,
        loadingState,
        isSearch,
    isFilter,
        searchList,
        filterList,
      ];
}
