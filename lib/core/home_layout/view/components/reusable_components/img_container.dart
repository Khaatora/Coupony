
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImgContainer extends StatelessWidget {
  const ImgContainer({
    super.key,
    this.imgLink =
        "https://mir-s3-cdn-cf.behance.net/projects/404/1cb86469753415.Y3JvcCwxMTUwLDg5OSwxMzc1LDY0Mw.jpg",
    this.width = 130,
    this.height = 100});

  final String imgLink;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(25),
        child: CachedNetworkImage(imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),imageUrl: imgLink, width: width,),
      ),
    );
  }
}
