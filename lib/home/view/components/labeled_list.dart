import 'package:flutter/material.dart';
import 'package:maslaha/core/home_layout/model/get_data_campaigns_response.dart';
import 'package:maslaha/core/home_layout/view/components/reusable_components/img_container.dart';

import '../../../core/home_layout/view_model/home_layout_cubit.dart';

class LabeledList extends StatelessWidget {
  const LabeledList({super.key, required this.text, required this.getDataCampaignResponse, required this.channel });

  final String text;
  final GetDataCampaignsResponse getDataCampaignResponse;
  final String channel;

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
                itemCount: getDataCampaignResponse.campaigns.length,
                itemBuilder: (context, index) {
                return GestureDetector(onTap: () async {
                  await HomeLayoutCubit.get(context).getCoupon(channel, getDataCampaignResponse.campaigns[index].data.campaignId);
                },child: ImgContainer(imgLink: getDataCampaignResponse.campaigns[index].logo.url,));
              },),
            ),
          ),
        ],
      ),
    );
  }
}
