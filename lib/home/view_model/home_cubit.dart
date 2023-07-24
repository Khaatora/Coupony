import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/constants/app_images.dart';
import 'package:maslaha/core/utils/enums/loading_enums.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  void setCurrentImgIndex(int index) {
    emit(state.copyWith(
        currentShownImgIndex: index
            ));
  }
}
