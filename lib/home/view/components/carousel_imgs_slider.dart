import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/home/view_model/home_cubit.dart';

import '../../../core/constants/app_images.dart';

class CarouselImgsSlider extends StatelessWidget {
  const CarouselImgsSlider({
    Key? key,
    this.currentIndex = 0,
    required this.imgList,
  }) : super(key: key);
  final int currentIndex;
  final List<String> imgList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CarouselSlider(
              items: AppImages.carouselImages
                  .map((img) => Builder(
                        builder: (context) {
                          return Image.network(
                            img,
                            fit: BoxFit.cover,
                            height: 200,
                          );
                        },
                      ))
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 200,
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
                            ? const Color.fromRGBO(0, 0, 0, 0.9)
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
