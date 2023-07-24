import 'package:flutter/material.dart';
import 'package:maslaha/core/home_layout/view/components/reusable_components/img_container.dart';

class LabeledList extends StatelessWidget {
  const LabeledList({super.key, required this.text, this.imgList = const [
    "https://mir-s3-cdn-cf.behance.net/projects/404/1cb86469753415.Y3JvcCwxMTUwLDg5OSwxMzc1LDY0Mw.jpg",
    "https://mir-s3-cdn-cf.behance.net/projects/404/1cb86469753415.Y3JvcCwxMTUwLDg5OSwxMzc1LDY0Mw.jpg",
    "https://mir-s3-cdn-cf.behance.net/projects/404/1cb86469753415.Y3JvcCwxMTUwLDg5OSwxMzc1LDY0Mw.jpg",
    "https://mir-s3-cdn-cf.behance.net/projects/404/1cb86469753415.Y3JvcCwxMTUwLDg5OSwxMzc1LDY0Mw.jpg",
    "https://mir-s3-cdn-cf.behance.net/projects/404/1cb86469753415.Y3JvcCwxMTUwLDg5OSwxMzc1LDY0Mw.jpg",
  ]});

  final String text;
  final List<String> imgList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
      child: Column(
        children: [
          Align(alignment: Alignment.topLeft,child: Text(text)),
           Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imgList.length,
                itemBuilder: (context, index) {
                return ImgContainer(imgLink: imgList[index],);
              },),
            ),
          ),
        ],
      ),
    );
  }
}
