import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/global/colors.dart';
import 'package:maslaha/core/home_layout/view_model/home_layout_cubit.dart';
import 'package:maslaha/home/model/get_banner_response.dart';
import 'package:maslaha/home/view_model/home_cubit.dart';


class CarouselImgsSlider extends StatelessWidget {
  const CarouselImgsSlider({
    Key? key,
    this.currentIndex = 0,
    required this.imgList,
  }) : super(key: key);
  final int currentIndex;
  final List<BannerData> imgList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CarouselSlider(
              items: imgList
                  .map((img) => InkWell(
                      onTap: () async {
                        await HomeLayoutCubit.get(context).getCoupon(img.channel, img.campaignId);
                      },
                      child: CachedNetworkImage(
                        imageUrl: img.banner,
                        fit: BoxFit.fitHeight,
                      )))
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  HomeCubit.get(context).setCurrentImgIndex(index);
                },
              ),
            ),
          ),
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                current.currentShownImgIndex != previous.currentShownImgIndex,
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.map((img) {
                  int index = imgList.indexOf(img);
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: 16.0,
                    height: 16.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 2,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: state.currentShownImgIndex == index
                            ? AppColor.primaryColor
                            : const Color.fromRGBO(0, 0, 0, 0.4)),
                  );
                }).toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
