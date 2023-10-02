import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/home_layout/view/components/reusable_components/img_container.dart';
import 'package:maslaha/core/home_layout/view_model/home_layout_cubit.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget(
      {required this.query, required this.cubit, super.key});

  final String query;
  final Cubit<HomeLayoutState> cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.getDataCampaignsResponse!.campaigns.length,
          itemBuilder: (context, index) {
            //TODO: change channel
            return GestureDetector(
                onTap: () => (cubit as HomeLayoutCubit).getCoupon(
                    "0",
                    state.getDataCampaignsResponse!.campaigns[index].data
                        .campaignId),
                child: ImgContainer(
                  imgLink: state
                      .getDataCampaignsResponse!.campaigns[index].logo.name,
                ));
          },
        );
      },
    );
  }
}
