import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/utils/enums/create_or_remove_favorite_state.dart';

import '../../core/componets/custom_text_container.dart';
import '../../core/global/localization.dart';
import '../../core/global/size_config.dart';
import '../../core/home_layout/model/get_data_campaigns_response.dart';
import '../../core/home_layout/view/components/reusable_components/main_label.dart';
import '../../core/home_layout/view/components/reusable_components/secondary_coupon_redeem_card.dart';
import '../../core/home_layout/view_model/home_layout_cubit.dart';
import '../../core/utils/enums/apis/get_favorites_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
              text: EnglishLocalization.favorites,
              icon: Icons.favorite,
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
            child: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
              buildWhen: (previous, current) =>
                  current.getFavoritesState != previous.getFavoritesState ||
                  current.createOrRemoveFavoriteState !=
                      previous.createOrRemoveFavoriteState,
              builder: (context, homeLayoutState) {
                switch (homeLayoutState.getFavoritesState) {
                  case GetFavoritesState.loading:
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  case GetFavoritesState.loaded:
                    final List<Campaign> tempList = homeLayoutState
                        .getDataCampaignsResponse!.campaigns
                        .where((campaign) => campaign.data.isFav)
                        .toList();
                    if (tempList.isEmpty) {
                      return const Center(
                        child: Text(
                          EnglishLocalization.youHaveNoFavorites,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: tempList.length,
                      itemBuilder: (context, index) {
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
                                  ? HomeLayoutCubit.get(context).removeFavorite(
                                      tempList[index].data.campaignId)
                                  : HomeLayoutCubit.get(context).createFavorite(
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
                  case GetFavoritesState.error:
                    return Center(
                      child: Text(homeLayoutState.message),
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
