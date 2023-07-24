import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/global/localization.dart';
import '../../core/home_layout/view/components/reusable_components/categories_list.dart';
import '../../core/home_layout/view/components/reusable_components/main_label.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: MainLabel(
              text: EnglishLocalization.favourites,
              icon: Icons.favorite,
            ),
          ),
          CategoriesList(),
        ],
      ),
    );
  }
}
