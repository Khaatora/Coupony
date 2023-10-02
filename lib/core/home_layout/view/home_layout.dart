import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/constants/routes.dart';
import 'package:maslaha/core/global/localization.dart';
import 'package:maslaha/core/home_layout/view_model/home_layout_cubit.dart';
import 'package:maslaha/core/utils/enums/apis/get_coupons_state.dart';
import 'package:maslaha/core/utils/enums/apis/get_favorites_state.dart';
import 'package:maslaha/core/utils/enums/create_or_remove_favorite_state.dart';
import 'package:maslaha/core/utils/enums/menu_items_enums.dart';
import 'package:maslaha/core/utils/enums/search_state_enums.dart';
import 'package:maslaha/core/utils/general_utils.dart';
import '../../global/colors.dart';
import '../../services/services_locator.dart';
import '../../utils/bottoms_sheets/bottom_sheet.dart';
import '../../utils/enums/bottom_nav_enums.dart';
import '../../utils/enums/loading_enums.dart';
import '../../utils/loading_screens/overlay/loading_screen.dart';
import '../model/get_data_campaigns_response.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<HomeLayoutCubit>()..initiatePeriodicInternetConnectionCheck(),
      child: const BottomNavBarView(),
    );
  }
}

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {

  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    HomeLayoutCubit.get(context).initData();
    log("initData called");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listenWhen: (previous, current) =>
      current.showLoadingScreen != previous.showLoadingScreen ||
          current.searchState != previous.searchState || current.createOrRemoveFavoriteState == CreateOrRemoveFavoriteState.error || current.getFavoritesState == GetFavoritesState.error && (current.loadingState != previous.loadingState || current.message != EnglishLocalization.somethingWentWrongLoadingData),
      buildWhen: (previous, current) =>
          current.currentIndex != previous.currentIndex,
        listener: (context, state) {
          if (state.showLoadingScreen) {
            sl<LoadingScreen>().show(
                context: context, text: EnglishLocalization.pleaseWaitAMoment);
          } else {
            sl<LoadingScreen>().hide();
            if (state.loadingState == LoadingState.loaded && state.getCouponState == GetCouponState.loaded) {
              final Campaign tmpCampaignData = state.getDataCampaignsResponse!.campaigns
                  .firstWhere((element) {
                log("${element.data.campaignId ==
                    state.getCouponResponse!.couponData.campaignId}, ${element.data.name}");
                return element.data.campaignId ==
                    state.getCouponResponse!.couponData.campaignId;
              });
              _showCustomBottomSheet(
                  context,
                  state.getCouponResponse!.couponData.description,
                  state.getCouponResponse!.couponData.code,
                  tmpCampaignData.logo.url,
                  tmpCampaignData.data.link);
              HomeLayoutCubit.get(context).clearCouponData();
            } else if (state.loadingState == LoadingState.error || state.getCouponState == GetCouponState.error || state.searchState == SearchState.error || state.createOrRemoveFavoriteState == CreateOrRemoveFavoriteState.error || state.getFavoritesState == GetFavoritesState.error ) {
              context.showCustomSnackBar(
                  state.message, const Duration(seconds: 2), AppColor.red);
            }
          }
        },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: AppColor.appBarGradient,
                    ),
                  ),
                  title: Container(
                      height: 42,
                      alignment: Alignment.center,
                      child: Material(
                        borderRadius: BorderRadius.circular(24),
                        elevation: 5.0,
                        child: TextFormField(
                          textInputAction: TextInputAction.search,
                          keyboardType: TextInputType.text,
                          controller: _searchController,
                          textAlignVertical: TextAlignVertical.top,
                          // onTap: () {
                          //   showSearch(context: context, delegate: MySearchDelegate(availableSuggestions: state.getDataCampaignsResponse?.data.map((e) => e.name).toList() ?? [], homeLayoutCubit: HomeLayoutCubit.get(context)));
                          // },
                          onFieldSubmitted: (value) {
                              HomeLayoutCubit.get(context).search(_searchController.text);
                          },
                          style: const TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.search,
                                color: AppColor.primaryColor,
                                size: 24,
                              ),
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                      "assets/icons/infinity_Icon.png"),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const VerticalDivider(
                                    width: 2,
                                    indent: 5,
                                    endIndent: 5,
                                    color: AppColor.grey,
                                  ),
                                ],
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 8),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                              borderSide: BorderSide.none,
                            ),
                            hintText: EnglishLocalization.search,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )),
                  actions: [
                    PopupMenuButton<MenuItem>(
                      padding: const EdgeInsets.only(),
                      icon: Icon(Icons.adaptive.more, color: AppColor.navyBlue,),
                      onSelected: (value) {
                        switch (value) {
                          case MenuItem.Settings:
                            FocusManager.instance.primaryFocus?.unfocus();
                            Navigator.pushNamed(context, Routes.settings);
                            break;
                          case MenuItem.Logout:
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: MenuItem.Settings,
                          child: Row(
                            children: [
                              Icon(
                                Icons.settings,
                                color: AppColor.primaryColor,
                              ),
                              const Spacer(),
                              Text(MenuItem.Settings.name),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: MenuItem.Logout,
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout_outlined,
                                color: AppColor.primaryColor,
                              ),
                              const Spacer(),
                              Text(MenuItem.Logout.name),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            body: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
              buildWhen: (previous, current) =>
                  (current.loadingState != previous.loadingState) ||
                  current.currentIndex != previous.currentIndex,
              builder: (context, state) {
                switch (state.loadingState) {
                  case LoadingState.init:
                  case LoadingState.loading:
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  case LoadingState.loaded:
                    return HomeLayoutCubit.get(context)
                        .pages[state.currentIndex];
                  case LoadingState.error:
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(EnglishLocalization
                                .somethingWentWrongLoadingData, textAlign: TextAlign.center, style: TextStyle(
                              fontSize: 14,
                            )),
                            const SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                                onPressed: () =>
                                    HomeLayoutCubit.get(context).initData(),
                                child: const Text(
                                  EnglishLocalization.tryAgainButton,
                                  textAlign: TextAlign.center,
                                ))
                          ],
                        ),
                      ),
                    );
                }
              },
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(gradient: AppColor.appBarGradient),
              child: BottomNavigationBar(
                  currentIndex: state.currentIndex,
                  selectedItemColor: AppColor.selectedNavBarColor,
                  unselectedItemColor: AppColor.unselectedNavBarColor,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  type: BottomNavigationBarType.fixed,
                  iconSize: 28,
                  onTap: HomeLayoutCubit.get(context).updateIndex,
                  items: [
                    //HOME
                    BottomNavigationBarItem(
                      label: BottomNavScreen.values[0].name,
                      icon: Container(
                        width: state.bottomNavBarItemWidth,
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                            color: state.currentIndex == 0
                                ? AppColor.selectedNavBarColor
                                : AppColor.backgroundColor,
                            width: state.bottomNavBarItemBorderWidth,
                          )),
                        ),
                        child: const Icon(Icons.home_outlined),
                      ),
                    ),
                    //COUPON
                    BottomNavigationBarItem(
                        label: BottomNavScreen.values[1].name,
                        icon: Container(
                          width: state.bottomNavBarItemWidth,
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                              color: state.currentIndex == 1
                                  ? AppColor.selectedNavBarColor
                                  : AppColor.backgroundColor,
                              width: state.bottomNavBarItemBorderWidth,
                            )),
                          ),
                          child: const Icon(Icons.sell_outlined),
                        )),
                    //FAVOURITE
                    BottomNavigationBarItem(
                      label: BottomNavScreen.values[2].name,
                      icon: Container(
                          width: state.bottomNavBarItemWidth,
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                              color: state.currentIndex == 2
                                  ? AppColor.selectedNavBarColor
                                  : AppColor.backgroundColor,
                              width: state.bottomNavBarItemBorderWidth,
                            )),
                          ),
                          child: const Icon(
                            Icons.favorite_outline,
                          )),
                    ),
                    //FOR_YOU
                    BottomNavigationBarItem(
                      label: "For You",
                      icon: Container(
                          width: state.bottomNavBarItemWidth,
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                              color: state.currentIndex == 3
                                  ? AppColor.selectedNavBarColor
                                  : AppColor.backgroundColor,
                              width: state.bottomNavBarItemBorderWidth,
                            )),
                          ),
                          child: const Icon(
                            Icons.person_outline,
                          )),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }


  Future<void> _showCustomBottomSheet(
      BuildContext context, String title, String content, String logoUrl, String storeUrl) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      builder: (context) {
        return CouponBottomSheet(
          title: title, content: content, logoUrl: logoUrl, storeUrl: storeUrl,);
      },
    );
  }
}
