import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/utils/enums/loading_enums.dart';

import '../../repository/i_login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ILoginRepository loginRepository;

  LoginCubit(this.loginRepository)
      : super(const LoginState(
          email: "unknown",
        ));

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  Future<void> login(LoginParams params) async {
    emit(state.copyWith(
      email: params.email,
      loadingState: LoadingState.loading,
    ));
    final result = await loginRepository.login(params);
    result.fold(
      (l) => emit(
          state.copyWith(message: l.message, loadingState: LoadingState.error)),
      (r) {
        emit(state.copyWith(
          loadingState: LoadingState.loaded,
        ));
      },
    );
  }

  Future<void> guestLogin() async {
    emit(state.copyWith(
      loadingState: LoadingState.loading,
    ));
    final result = await loginRepository.guestLogin();
    result.fold(
      (l) => emit(
          state.copyWith(message: l.message, loadingState: LoadingState.error)),
      (r) {
        emit(state.copyWith(
          loadingState: LoadingState.loaded,
        ));
      },
    );
  }
}
