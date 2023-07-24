import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/home_layout/view_model/home_layout_cubit.dart';

import '../../../../global/size_config.dart';
import '../../../../../home/view/components/reusable_components/small_text_container.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
      buildWhen: (previous, current) => current.categories != previous.categories,
      builder: (context, state) {
        return SizedBox(
          height: SizeConfig.safeBlockVertical*4,
          child: ListView.builder(
            itemCount: state.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SmallTextContainer(text: state.categories[index], onTap: () {
              },);
            },),
        );
      },
    );
  }
}
