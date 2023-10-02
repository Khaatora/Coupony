import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/global/colors.dart';
import 'package:maslaha/core/global/localization.dart';
import 'package:maslaha/core/global/size_config.dart';
import 'package:maslaha/core/home_layout/view/components/reusable_components/main_label.dart';
import 'package:maslaha/core/home_layout/view/components/reusable_components/secondary_coupon_redeem_card.dart';
import 'package:maslaha/core/home_layout/view_model/home_layout_cubit.dart';
import 'package:maslaha/coupon/view_models/coupons_cubit.dart';
import '../../core/componets/custom_text_container.dart';
import '../../core/home_layout/model/get_data_campaigns_response.dart';
import '../../core/services/services_locator.dart';
import '../../core/utils/enums/create_or_remove_favorite_state.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CouponsCubit>()..initCubit(),
      child: const CouponsView(),
    );
  }
}

class CouponsView extends StatelessWidget {
  const CouponsView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<CouponsCubit, CouponsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: MainLabel(
                  text: state.title,
                  imgPath: "assets/icons/Sale Price Tag.png",
                ),
              ),
              BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
                buildWhen: (previous, current) =>
                    current.categories != previous.categories ||
                    current.searchState != previous.searchState,
                builder: (context, homeLayoutState) {
                  if (homeLayoutState.categories == null) {
                    return SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  }
                  return SizedBox(
                    height: SizeConfig.safeBlockVertical * 4,
                    child: ListView.builder(
                      itemCount: homeLayoutState.categories!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final String categoryName =
                            homeLayoutState.categories![index].categoryName;
                        return CustomTextButton(
                          text: categoryName,
                          onTap: () => state.isFilter &&
                                  state.title == categoryName
                              ? CouponsCubit.get(context).unfilter()
                              : CouponsCubit.get(context).filterAndShowResults(
                                  homeLayoutState.getDataCampaignsResponse!,
                                  categoryName),
                          color: categoryName == state.title
                              ? AppColor.primaryColor
                              : AppColor.lightGrey,
                          textColor: categoryName == state.title
                              ? AppColor.white
                              : AppColor.black,
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              (state.campaignsList.isEmpty &&
                      state.filterList.isEmpty &&
                      state.searchList.isEmpty)
                  ? const Expanded(
                      child: Center(
                        child: Text(EnglishLocalization.coudlntFindAnyStores),
                      ),
                    )
                  : Expanded(
                      child: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
                        buildWhen: (previous, current) =>
                            current.createOrRemoveFavoriteState !=
                            previous.createOrRemoveFavoriteState,
                        builder: (context, homeLayoutState) {
                          log(">>>>>>>>>>>>>>>>>>>>>>>reloaded<<<<<<<<<<<<<<<<< -- ${homeLayoutState.createOrRemoveFavoriteState}");
                          return ListView.builder(
                            itemCount: state.isSearch
                                ? state.searchList.length
                                : (state.isFilter
                                    ? state.filterList.length
                                    : state.campaignsList.length),
                            itemBuilder: (context, index) {
                              final List<Campaign> tempList = state.isSearch
                                  ? state.searchList
                                  : (state.isFilter
                                      ? state.filterList
                                      : state.campaignsList);
                              log(tempList[index].data.name);
                              return SecondaryCouponRedeemCard(
                                mainButtonOnPressed: () async {
                                  await HomeLayoutCubit.get(context).getCoupon(
                                      "home", tempList[index].data.campaignId);
                                },
                                iconOnPressed: homeLayoutState
                                            .createOrRemoveFavoriteState ==
                                        CreateOrRemoveFavoriteState.loading
                                    ? null
                                    : () => (tempList[index].data.isFav
                                        ? HomeLayoutCubit.get(context)
                                            .removeFavorite(
                                                tempList[index].data.campaignId)
                                        : HomeLayoutCubit.get(context)
                                            .createFavorite(tempList[index]
                                                .data
                                                .campaignId)),
                                title: tempList[index].data.name,
                                logoUrl: tempList[index].logo.url,
                                buttonWidth: SizeConfig.screenWidth * 0.4,
                                favorite: homeLayoutState
                                            .createOrRemoveFavoriteState ==
                                        CreateOrRemoveFavoriteState.loading
                                    ? !tempList[index].data.isFav
                                    : tempList[index].data.isFav,
                                enableFeedback: homeLayoutState
                                        .createOrRemoveFavoriteState !=
                                    CreateOrRemoveFavoriteState.loading,
                              );
                            },
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
