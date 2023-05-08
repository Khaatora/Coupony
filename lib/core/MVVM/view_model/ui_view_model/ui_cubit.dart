import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ui_state.dart';

class UiCubit extends Cubit<UIState> {
  UiCubit() : super(const UIState());

  static UiCubit get(context) => BlocProvider.of<UiCubit>(context);

  void changePasswordVisibility(){
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }
}
