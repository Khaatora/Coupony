import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/home_layout/view_model/home_layout_cubit.dart';
import 'package:maslaha/home/view_model/home_cubit.dart';

import '../../../../core/global/localization.dart';
import '../../../../core/utils/enums/apis/get_banners_state.dart';
import '../../../model/get_banner_response.dart';

class AdContainer extends StatelessWidget {
  const AdContainer({
    super.key,
    this.imgLink =
        "https://mir-s3-cdn-cf.behance.net/projects/404/1cb86469753415.Y3JvcCwxMTUwLDg5OSwxMzc1LDY0Mw.jpg",
    required this.channel,
  });

  final String imgLink;
  final String channel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.getBannersState != current.getBannersState,
      builder: (context, state) {
        switch (state.getBannersState) {
          case GetBannersState.loading:
            return const CircularProgressIndicator.adaptive();
          case GetBannersState.loaded:
            final BannerData tmpBannerData = state.getBannerResponse!.data.firstWhere((element) => element.channel == channel);
            return GestureDetector(
              onTap: () => HomeLayoutCubit.get(context).getCoupon(channel, tmpBannerData.campaignId),
              child: CachedNetworkImage(
                imageUrl: tmpBannerData.banner,
                imageBuilder: (context, imageProvider) => Container(
                  margin: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image:
                        DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            );
          case GetBannersState.error:
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => HomeCubit.get(context).getBanners(),
                      child: const Text(
                        EnglishLocalization.tryAgainButton,
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            );
        }
      },
    );
  }
}
