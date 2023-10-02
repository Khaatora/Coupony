import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/for_you/view_models/for_you_cubit.dart';

import '../../core/componets/custom_text_container.dart';
import '../../core/global/localization.dart';
import '../../core/global/size_config.dart';
import '../../core/home_layout/model/get_data_campaigns_response.dart';
import '../../core/home_layout/view/components/reusable_components/main_label.dart';
import '../../core/home_layout/view/components/reusable_components/secondary_coupon_redeem_card.dart';
import '../../core/home_layout/view_model/home_layout_cubit.dart';
import '../../core/services/services_locator.dart';
import '../../core/utils/enums/create_or_remove_favorite_state.dart';
import '../../core/utils/enums/loading_enums.dart';

class ForYouScreen extends StatelessWidget {
  const ForYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final HomeLayoutState homeLayoutState =
            HomeLayoutCubit.get(context).state;
        return sl<ForYouCubit>()
          ..getRecommendations(
              homeLayoutState.getDataCampaignsResponse!,
              homeLayoutState.userData!.region,
              homeLayoutState.userData!.token);
      },
      child: const ForYouView(),
    );
  }
}

class ForYouView extends StatelessWidget {
  const ForYouView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: MainLabel(
              text: EnglishLocalization.forYou,
              icon: Icons.person,
            ),
          ),
          BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
            buildWhen: (previous, current) =>
                current.categories != previous.categories,
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
                      onTap: () => HomeLayoutCubit.get(context)
                          .switchAndFilter(categoryName),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocBuilder<ForYouCubit, ForYouState>(
              buildWhen: (previous, current) =>
                  current.loadingState != previous.loadingState,
              builder: (context, state) {
                log(">>>>>>>>>>>>>>>>>>>>>>>reloaded<<<<<<<<<<<<<<<<<");
                switch (state.loadingState) {
                  case LoadingState.init:
                  case LoadingState.loading:
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  case LoadingState.loaded:
                    return BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
                      buildWhen: (previous, current) =>
                          current.createOrRemoveFavoriteState !=
                          previous.createOrRemoveFavoriteState,
                      builder: (context, homeLayoutState) {
                        log(">>>>>>>>>>>>>>>>>>>>>>>reloaded<<<<<<<<<<<<<<<<< -- ${homeLayoutState.createOrRemoveFavoriteState}");
                        return ListView.builder(
                          itemCount: homeLayoutState
                              .getDataCampaignsResponse!.campaigns.length,
                          itemBuilder: (context, index) {
                            final List<Campaign> tempList = homeLayoutState
                                .getDataCampaignsResponse!.campaigns;
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
                                          .createFavorite(
                                              tempList[index].data.campaignId)),
                              title: tempList[index].data.name,
                              logoUrl: tempList[index].logo.url,
                              buttonWidth: SizeConfig.screenWidth * 0.4,
                              favorite:
                                  homeLayoutState.createOrRemoveFavoriteState ==
                                          CreateOrRemoveFavoriteState.loading
                                      ? !tempList[index].data.isFav
                                      : tempList[index].data.isFav,
                              enableFeedback:
                                  homeLayoutState.createOrRemoveFavoriteState !=
                                      CreateOrRemoveFavoriteState.loading,
                            );
                          },
                        );
                      },
                    );
                  case LoadingState.error:
                    return const Center(
                      child: Text(
                          EnglishLocalization.somethingWentWrongLoadingData,
                          textAlign: TextAlign.center),
                    );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
