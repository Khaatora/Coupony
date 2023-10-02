import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maslaha/core/global/colors.dart';
import 'package:maslaha/core/global/localization.dart';

import '../../../../global/size_config.dart';

class SecondaryCouponRedeemCard extends StatelessWidget {
  const SecondaryCouponRedeemCard(
      {super.key,
      this.iconOnPressed,
      this.favorite = false,
      required this.logoUrl,
      required this.title,
      required this.mainButtonOnPressed,
      this.buttonWidth,
      required this.enableFeedback});

  final VoidCallback? iconOnPressed;
  final VoidCallback mainButtonOnPressed;
  final bool favorite;
  final bool enableFeedback;
  final String logoUrl;
  final String title;
  final double? buttonWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              offset: Offset(0.0, 5.0),
            )
          ]),
      child: SizedBox(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: const EdgeInsets.all(8),
                    isSelected: favorite,
                    tooltip: EnglishLocalization.addToFavorites,
                    alignment: Alignment.topRight,
                    onPressed: iconOnPressed,
                    enableFeedback: enableFeedback,
                    highlightColor: enableFeedback ? null : AppColor.transparent,
                    disabledColor: AppColor.grey,
                    color: AppColor.primaryColor,
                    icon: const Icon(
                      Icons.favorite_outline,
                    ),
                    selectedIcon: const Icon(
                      Icons.favorite,
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        imageUrl: logoUrl,
                        width: 50,
                        height: 50,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Align(
                        heightFactor: 1.8,
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColor.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              height: 4,
              indent: 40,
              endIndent: 40,
            ),
            const SizedBox(
              height: 4,
            ),
            ElevatedButton(
                onPressed: mainButtonOnPressed,
                style: ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(Size.fromWidth(
                        buttonWidth ?? SizeConfig.screenWidth * 0.5)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                    backgroundColor:
                        MaterialStatePropertyAll(AppColor.navyBlue)),
                child: const Text(EnglishLocalization.getCode)),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
