import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/global/size_config.dart';
import 'package:maslaha/core/home_layout/view_model/home_layout_cubit.dart';
import 'package:maslaha/home/view/components/carousel_imgs_slider.dart';
import 'package:maslaha/home/view/components/labeled_list.dart';
import 'package:maslaha/home/view/components/reusable_components/ad_container.dart';
import 'package:maslaha/home/view_model/home_cubit.dart';

import '../../core/componets/custom_text_container.dart';
import '../../core/global/localization.dart';
import '../../core/services/services_locator.dart';
import '../../core/utils/enums/apis/get_banners_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..getBanners(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  current.getBannersState != previous.getBannersState,
              builder: (context, state) {
                switch (state.getBannersState) {
                  case GetBannersState.loading:
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  case GetBannersState.loaded:
                    return CarouselImgsSlider(
                      imgList: state.getBannerResponse!.data,
                    );
                  case GetBannersState.error:
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () =>
                                    HomeCubit.get(context).getBanners(),
                                child: const Text(
                                  EnglishLocalization.tryAgainButton,
                                  textAlign: TextAlign.center,
                                ))
                          ],
                        ),
                      ),
                    );
                }
              }),
          BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
            buildWhen: (previous, current) =>
            current.categories != previous.categories,
            builder: (context, homeLayoutState) {
              if (homeLayoutState.categories == null) {
                return SizedBox(height: SizeConfig.safeBlockVertical * 4,
                  child: const Center(child: CircularProgressIndicator.adaptive(),),);
              }
              return SizedBox(
                height: SizeConfig.safeBlockVertical * 4,
                child: ListView.builder(
                  itemCount: homeLayoutState.categories!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final String categoryName = homeLayoutState.categories![index].categoryName;
                    return CustomTextButton(
                      text: categoryName,
                      onTap: () => HomeLayoutCubit.get(context).switchAndFilter(categoryName),);
                  },),
              );
            },
          ),
          BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
            buildWhen: (previous, current) =>
                current.getDataCampaignsResponse !=
                previous.getDataCampaignsResponse,
            builder: (context, state) {
              return LabeledList(
                text: EnglishLocalization.topStores,
                getDataCampaignResponse: state.getDataCampaignsResponse!,
                channel: "home",
              );
            },
          ),
          const AdContainer(channel: "slideshow"),
          BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
            buildWhen: (previous, current) =>
                current.getDataCampaignsResponse !=
                previous.getDataCampaignsResponse,
            builder: (context, state) {
              return LabeledList(
                text: EnglishLocalization.topDeals,
                getDataCampaignResponse: state.getDataCampaignsResponse!,
                channel: "home",
              );
            },
          ),
          const AdContainer(channel: "slideshow"),
          BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
            buildWhen: (previous, current) =>
                current.getDataCampaignsResponse !=
                previous.getDataCampaignsResponse,
            builder: (context, state) {
              return LabeledList(
                text: EnglishLocalization.newArrivals,
                getDataCampaignResponse: state.getDataCampaignsResponse!,
                channel: "home",
              );
            },
          ),
          const AdContainer(channel: "slideshow"),
          BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
            buildWhen: (previous, current) =>
                current.getDataCampaignsResponse !=
                previous.getDataCampaignsResponse,
            builder: (context, state) {
              return LabeledList(
                text: EnglishLocalization.todaysDeals,
                getDataCampaignResponse: state.getDataCampaignsResponse!,
                channel: "home",
              );
            },
          ),
          const AdContainer(channel: "slideshow"),
        ],
      ),
    );
  }
}
