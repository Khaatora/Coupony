import 'package:flutter/material.dart';

class AdContainer extends StatelessWidget {
  const AdContainer({
    super.key,
    this.imgLink =
        "https://mir-s3-cdn-cf.behance.net/projects/404/1cb86469753415.Y3JvcCwxMTUwLDg5OSwxMzc1LDY0Mw.jpg",
  });

  final String imgLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
        image: Image.network(
          imgLink,
        ).image,
            fit: BoxFit.cover,
      )),
    );
  }
}
