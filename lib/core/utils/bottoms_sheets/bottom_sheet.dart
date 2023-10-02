import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maslaha/core/global/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../global/localization.dart';
import '../../global/size_config.dart';

class CouponBottomSheet extends StatelessWidget {
  const CouponBottomSheet(
      {super.key,
      required this.title,
      required this.content,
      required this.logoUrl,
      required this.storeUrl});

  final String title;
  final String content;
  final String logoUrl;
  final String storeUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                width: 60,
                height: 60,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(width: 16,),
              SizedBox(
                width: 200,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColor.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.navyBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.4,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.white),
                  margin: const EdgeInsets.all(4),
                  child: Text(
                    content,
                    style: const TextStyle(color: AppColor.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: content));
                  },
                  child: const Text(EnglishLocalization.copy,
                    style: TextStyle(color: AppColor.white),),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () {
                openUrl(storeUrl);
              },
              style: ButtonStyle(
                fixedSize: MaterialStatePropertyAll(
                  Size.fromWidth(SizeConfig.screenWidth * 0.5)
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )
                )
              ),
              child: const Text(EnglishLocalization.visitStore)),
        ],
      ),
    );
  }

  void openUrl(String? url) async{
    log(url ?? "empty");
    if(url == null){
      return;
    }
    var uri = Uri.parse(url);
    if(await canLaunchUrl(uri)){
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
