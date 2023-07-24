import 'package:flutter/cupertino.dart';
import 'package:maslaha/core/global/localization.dart';
import 'package:maslaha/core/home_layout/view/components/reusable_components/categories_list.dart';
import 'package:maslaha/core/home_layout/view/components/reusable_components/main_label.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: MainLabel(
              text: EnglishLocalization.coupons,
              imgPath: "assets/icons/Sale Price Tag.png",
            ),
          ),
          CategoriesList(),
        ],
      ),
    );
  }
}
