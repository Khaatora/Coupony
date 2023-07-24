import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/coupon/views/coupon_screen.dart';
import 'package:maslaha/favourites/views/favourites_screen.dart';
import 'package:maslaha/for_you/views/for_you_screen.dart';
import 'package:maslaha/home/model/get_data_campaigns_response.dart';

import '../../../home/view/home_screen.dart';
import '../../utils/enums/bottom_nav_enums.dart';
import '../../utils/enums/loading_enums.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(const HomeLayoutState());

  List<Widget> get pages => [
    const HomeScreen(),
    const CouponScreen(),
    const FavouritesScreen(),
    const ForYouScreen(),
  ];

  static HomeLayoutCubit get(context) => BlocProvider.of<HomeLayoutCubit>(context);

  void updateIndex(int index){
    emit(state.copyWith(currentIndex: index));
  }
}
