import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/home_layout/view_model/home_layout_cubit.dart';

import '../../../../global/size_config.dart';
import '../../../../componets/custom_text_container.dart';

class CategoriesList<cubit extends StateStreamable<state>, state> extends StatelessWidget {
  const CategoriesList({super.key, this.listView});

  final Widget? listView;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
      buildWhen: (previous, current) =>
      current.categories != previous.categories,
      builder: (context, homeLayoutState) {
        if (homeLayoutState.categories == null) {
          return SizedBox(height: SizeConfig.safeBlockVertical * 4,
            child: const Center(child: CircularProgressIndicator.adaptive(),),);
        }
        return listView ?? SizedBox(
          height: SizeConfig.safeBlockVertical * 4,
          child: ListView.builder(
            itemCount: homeLayoutState.categories!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CustomTextButton(
                text: homeLayoutState.categories![index].categoryName,
                onTap: () {},);
            },),
        );
      },
    );
  }
}
