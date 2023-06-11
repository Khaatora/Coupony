import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/i_signup_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  ISignupRepository signupRepository;

  SignupCubit(this.signupRepository) : super(const SignupState());

  static List<String> get gender => ["Male", "Female"];

  static SignupCubit get(context) => BlocProvider.of<SignupCubit>(context);


  Future<void> signUp() async {
    emit(state.copyWith(signUpState: SignUpState.finishingUp));
    final result = await signupRepository.signup(SignupParams(
      state.sessionId,
    ));

    result.fold((l) {
      emit(state.copyWith(signUpState: SignUpState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(
        signUpState: SignUpState.success,
      ));
    });
  }

  Future<void> verifyEmail(
      String email, String password, String dob) async {
    emit(state.copyWith(signUpState: SignUpState.awaitingCode));
    // String tempDOB = "${dob.year}-${dob.month}-${dob.day}";
    final result = await signupRepository.verifyEmail(EmailVerificationParams(
      email: email,
      password: password,
      dob: dob,
      gender: state.gender,
    ));

    result.fold((l) {
      emit(state.copyWith(signUpState: SignUpState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(
          signUpState: SignUpState.awaitingUserInput, sessionId: r.sessionId, email: email,));
    });
  }

  Future<void> verifyCode(String code) async {
    emit(state.copyWith(signUpState: SignUpState.verifyingCode));
    final result = await signupRepository
        .verifyCode(CodeVerificationParams(state.sessionId, code));
    result.fold((l) {
      emit(state.copyWith(signUpState: SignUpState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(
          signUpState: SignUpState.finishingUp, sessionId: r.sessionId));
    });
  }


  void reInit(){
    emit(state.copyWith(signUpState: SignUpState.init));
  }

  void setDob(DateTime chosenDate) {
    emit(state.copyWith(
      dob: chosenDate
    ));
  }

  void setGender(String gender) {
    emit(state.copyWith(
        gender: gender,
    ));
  }
}
