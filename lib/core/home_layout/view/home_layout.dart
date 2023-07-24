import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/constants/routes.dart';
import 'package:maslaha/core/global/localization.dart';
import 'package:maslaha/core/home_layout/view_model/home_layout_cubit.dart';
import 'package:maslaha/core/utils/enums/menu_items_enums.dart';

import '../../global/colors.dart';
import '../../services/services_locator.dart';
import '../../utils/enums/bottom_nav_enums.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeLayoutCubit>(),
      child: const BottomNavBarView(),
    );
  }
}

class BottomNavBarView extends StatelessWidget {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
      buildWhen: (previous, current) =>
          current.currentIndex != previous.currentIndex,
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: AppColor.appBarGradient,
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                            height: 42,
                            alignment: Alignment.center,
                            child: Material(
                              borderRadius: BorderRadius.circular(24),
                              elevation: 5.0,
                              child: TextFormField(
                                textInputAction: TextInputAction.search,
                                keyboardType: TextInputType.text,
                                textAlignVertical: TextAlignVertical.top,
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
                      ),
                    ],
                  ),
                  actions: [
                    PopupMenuButton<MenuItem>(
                      padding: const EdgeInsets.only(),
                      onSelected: (value) {
                        switch (value) {
                          case MenuItem.Settings:
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
            body: HomeLayoutCubit.get(context).pages[state.currentIndex],
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
}
