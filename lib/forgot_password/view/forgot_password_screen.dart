import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/global/localization.dart';
import 'package:maslaha/core/utils/general_utils.dart';
import 'package:maslaha/forgot_password/view_model/forgot_password_cubit.dart';

import '../../core/componets/labeled_text_form_field_wtih_trailing.dart';
import '../../core/global/colors.dart';
import '../../core/global/size_config.dart';
import '../../core/services/services_locator.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgotPasswordCubit>(),
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _codeController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _codeController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            switch (state.passwordResetState) {
              case PasswordResetState.init:
                _firstPage();
                break;
              case PasswordResetState.verifyingEmail:
                context.hideCurrentSnackBar();
                context.showCustomSnackBar(
                  EnglishLocalization.checkEmail,
                  const Duration(seconds: 1),
                );
                break;
              case PasswordResetState.awaitingCodeInput:
                _pageForward();
                break;
              case PasswordResetState.verifyingCode:
                context.hideCurrentSnackBar();
                context.showCustomSnackBar(
                  EnglishLocalization.verifyingCode,
                  const Duration(seconds: 1),
                );
                break;
              case PasswordResetState.awaitingPasswordInput:
                _pageForward();
                break;
              case PasswordResetState.finishingUp:
                context.hideCurrentSnackBar();
                context.showCustomSnackBar(
                  EnglishLocalization.resettingPassword,
                  const Duration(seconds: 1),
                );
                break;
              case PasswordResetState.success:
                context.hideCurrentSnackBar();
                context.showCustomSnackBar(
                  EnglishLocalization.resetSuccessfully,
                  const Duration(seconds: 1),
                );
                break;
              case PasswordResetState.error:
                context.showCustomSnackBar(
                  state.message,
                  const Duration(seconds: 3),
                  Colors.red,
                );
                break;
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Form(
                  key: _formKey1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                          EnglishLocalization.enterEmailForPasswordReset,
                        style:
                      Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.left,),
                      const SizedBox(
                        height: 16,
                      ),
                      LabeledTextFormFieldWithTrailing(
                        textEditingController: _emailController,
                        validator: (email) {
                          if (email == null ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email)) {
                            return EnglishLocalization.enterValidEmail;
                          }
                          return null;
                        },
                        hintText: EnglishLocalization.email,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16,),
                      BlocBuilder<ForgotPasswordCubit,
                          ForgotPasswordState>(
                        buildWhen: (previous, current) =>
                            current.passwordResetState !=
                            previous.passwordResetState,
                        builder: (context, state) {
                          switch (state.passwordResetState) {
                            case PasswordResetState.init:
                            case PasswordResetState.awaitingCodeInput:
                            case PasswordResetState
                                .awaitingPasswordInput:
                            case PasswordResetState.success:
                            case PasswordResetState.error:
                              return Align(
                                alignment: Alignment.topRight,
                                child: ElevatedButton(
                                    onPressed: _verifyEmailExists,
                                    child: const Text(EnglishLocalization
                                        .continueText)),
                              );
                            case PasswordResetState.verifyingEmail:
                            case PasswordResetState.verifyingCode:
                            case PasswordResetState.finishingUp:
                              return const CircularProgressIndicator
                                  .adaptive();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Form(
                    key: _formKey2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<ForgotPasswordCubit,
                            ForgotPasswordState>(
                          buildWhen: (previous, current) =>
                              previous.email != current.email,
                          builder: (context, state) {
                            return Text(
                              "${EnglishLocalization.enterCodeSentTo}\n${state.email}",
                              style:
                                  Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.left,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LabeledTextFormFieldWithTrailing(
                          textEditingController: _codeController,
                          validator: _codeValidator,
                          hintText: EnglishLocalization.code,
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                        const Expanded(flex: 1,child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                ForgotPasswordCubit.get(context).reInit();
                                _pageBack();
                              },
                              icon: const Icon(Icons.arrow_back),
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    AppColor.primaryColor),
                              ),
                            ),
                            BlocBuilder<ForgotPasswordCubit,
                                ForgotPasswordState>(
                              buildWhen: (previous, current) =>
                                  current.passwordResetState !=
                                  previous.passwordResetState,
                              builder: (context, state) {
                                switch (state.passwordResetState) {
                                  case PasswordResetState.init:
                                  case PasswordResetState.awaitingCodeInput:
                                  case PasswordResetState
                                      .awaitingPasswordInput:
                                  case PasswordResetState.success:
                                  case PasswordResetState.error:
                                    return ElevatedButton(
                                      onPressed: _verifyCode,
                                      child: const Text(
                                          EnglishLocalization.confirmText),
                                    );
                                  case PasswordResetState.verifyingEmail:
                                  case PasswordResetState.verifyingCode:
                                  case PasswordResetState.finishingUp:
                                    return const CircularProgressIndicator
                                        .adaptive();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    )),
                Form(
                    key: _formKey3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          EnglishLocalization.enterYourNewPassword,style:
                        Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LabeledTextFormFieldWithTrailing(
                          textEditingController: _passwordController,
                          validator: _passwordValidator,
                          hintText: EnglishLocalization.password,
                        ),
                        LabeledTextFormFieldWithTrailing(
                          textEditingController: _confirmPasswordController,
                          validator: _confirmPasswordValidator,
                          hintText: EnglishLocalization.confirmPassword,
                        ),
                        const Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                ForgotPasswordCubit.get(context).reInit();
                                _pageBack();
                              },
                              icon: const Icon(Icons.arrow_back),
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    AppColor.primaryColor),
                              ),
                            ),
                            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                              buildWhen: (previous, current) =>
                                  current.passwordResetState !=
                                  previous.passwordResetState,
                              builder: (context, state) {
                                switch (state.passwordResetState) {
                                  case PasswordResetState.init:
                                  case PasswordResetState.awaitingCodeInput:
                                  case PasswordResetState.awaitingPasswordInput:
                                  case PasswordResetState.success:
                                  case PasswordResetState.error:
                                    return ElevatedButton(
                                      onPressed: _sendPassword,
                                      child: const Text(
                                          EnglishLocalization.continueText),
                                    );
                                  case PasswordResetState.verifyingEmail:
                                  case PasswordResetState.verifyingCode:
                                  case PasswordResetState.finishingUp:
                                    return const CircularProgressIndicator
                                        .adaptive();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verifyEmailExists() {
    if (_formKey1.currentState!.validate()) {
      ForgotPasswordCubit.get(context).verifyEmailExists(_emailController.text);
    }
  }

  void _verifyCode() {
    if (_formKey2.currentState!.validate()) {
      ForgotPasswordCubit.get(context).verifyCode(_codeController.text);
    }
  }

  void _sendPassword() {
    if (_formKey2.currentState!.validate()) {
      ForgotPasswordCubit.get(context).resetPassword(_passwordController.text);
    }
  }

  void _pageBack() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  void _firstPage() {
    _pageController.animateToPage(_pageController.initialPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  void _pageForward() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  String? _codeValidator(String? value) {
    if (value == null || value.isEmpty || value.length != 6) {
      return EnglishLocalization.enterValidCode;
    }
    return null;
  }

  String? _passwordValidator(password) {
    if (password == null || (password.length < 6 || password.length > 18)) {
      return EnglishLocalization.enterValidPassword;
    }
    return null;
  }

  String? _confirmPasswordValidator(password) {
    if (password != _passwordController.text) {
      return EnglishLocalization.passwordsDoNotMatch;
    }
    return null;
  }
}
