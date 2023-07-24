import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/constants/app_images.dart';
import 'package:maslaha/core/global/size_config.dart';
import 'package:maslaha/home/view/components/carousel_imgs_slider.dart';
import 'package:maslaha/core/home_layout/view/components/reusable_components/categories_list.dart';
import 'package:maslaha/home/view/components/labeled_list.dart';
import 'package:maslaha/home/view/components/reusable_components/ad_container.dart';
import 'package:maslaha/home/view_model/home_cubit.dart';

import '../../core/global/localization.dart';
import '../../core/services/services_locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>(),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const SingleChildScrollView(
      child: Column(
        children: [
          CarouselImgsSlider(
            imgList: AppImages.carouselImages,
          ),
          CategoriesList(),
          LabeledList(text: EnglishLocalization.topStores),
          AdContainer(),
        ],
      ),
    );
  }
}

