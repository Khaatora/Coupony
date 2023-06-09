import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/i_forgot_password_repository.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {

  final IForgotPasswordRepository forgotPasswordRepository;

  ForgotPasswordCubit(this.forgotPasswordRepository) : super(const ForgotPasswordState());

  static ForgotPasswordCubit get(context) => BlocProvider.of<ForgotPasswordCubit>(context);

  Future<void> verifyEmailExists(String email) async {
    emit(state.copyWith(passwordResetState: PasswordResetState.verifyingEmail));
    final result = await forgotPasswordRepository
        .initiatePasswordReset(InitiatePasswordResetParams(state.email));
    result.fold((l) {
      emit(state.copyWith(passwordResetState: PasswordResetState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(
          passwordResetState: PasswordResetState.awaitingCodeInput,email: email, sessionId: r.sessionId));
    });
  }

  Future<void> verifyCode(String code) async {
    emit(state.copyWith(passwordResetState: PasswordResetState.verifyingCode));
    final result = await forgotPasswordRepository
        .verifyCode(CodeVerificationParams(state.sessionId, code));
    result.fold((l) {
      emit(state.copyWith(passwordResetState: PasswordResetState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(
          passwordResetState: PasswordResetState.awaitingPasswordInput, sessionId: r.sessionId));
    });
  }

  Future<void> resetPassword(String password) async{
    emit(state.copyWith(passwordResetState: PasswordResetState.finishingUp));
    final result = await forgotPasswordRepository
        .resetPassword(ResetPasswordParams(state.sessionId, password));
    result.fold((l) {
      emit(state.copyWith(passwordResetState: PasswordResetState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(
          passwordResetState: PasswordResetState.success));
    });
  }

  void reInit(){
    emit(state.copyWith(passwordResetState: PasswordResetState.init));
  }

}
