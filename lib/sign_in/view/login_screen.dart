import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/componets/divider_with_centered_text.dart';
import 'package:maslaha/core/constants/routes.dart';
import 'package:maslaha/core/global/colors.dart';
import 'package:maslaha/core/global/localization.dart';
import 'package:maslaha/core/global/size_config.dart';
import 'package:maslaha/core/utils/general_utils.dart';
import 'package:maslaha/sign_in/view_model/login_view_model/login_cubit.dart';

import '../../core/MVVM/view_model/ui_view_model/ui_cubit.dart';
import '../../core/componets/labeled_text_form_field_wtih_trailing.dart';
import '../../core/services/services_locator.dart';
import '../../core/utils/enums/loading_enums.dart';
import '../repository/i_login_repository.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => sl<LoginCubit>(),
        ),
        BlocProvider<UiCubit>(
          create: (context) => UiCubit(),
        ),
      ],
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: SizeConfig.safeBlockVertical * 100,
          width: SizeConfig.safeBlockHorizontal * 100,
          child: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: BlocListener<LoginCubit, LoginState>(
              listenWhen: (previous, current) =>
                  current.loadingState == LoadingState.error,
              listener: (context, state) {
                switch (state.loadingState) {
                  case LoadingState.init:
                  case LoadingState.loading:
                  case LoadingState.loaded:
                    switch(state.type){
                      case LoginType.account:
                      case LoginType.guest:
                      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
                      break;
                    }
                    break;
                  case LoadingState.error:
                    context.showCustomSnackBar(
                      state.message,
                      const Duration(seconds: 1, milliseconds: 500),
                      AppColor.red,
                    );
                }
              },
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                        flex: 1,
                        child: Text(
                          EnglishLocalization.login,
                          style: Theme.of(context).textTheme.headlineMedium,
                        )),
                    LabeledTextFormFieldWithTrailing(
                      textEditingController: _emailController,
                      trailing: const Icon(
                        Icons.person_outline,
                        size: 30,
                      ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<UiCubit, UIState>(
                      builder: (context, state) {
                        return LabeledTextFormFieldWithTrailing(
                          textEditingController: _passwordController,
                          trailing: Container(
                            padding: const EdgeInsets.all(0),
                            width: 30,
                            child: IconButton(
                              onPressed: () {
                                UiCubit.get(context).changePasswordVisibility();
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: state.hidePassword
                                  ? const Icon(
                                      Icons.visibility_off,
                                    )
                                  : const Icon(Icons.visibility),
                            ),
                          ),
                          validator: (password) {
                            if (password == null ||
                                (password.length < 6 || password.length > 18)) {
                              return EnglishLocalization.enterValidPassword;
                            }
                            return null;
                          },
                          hintText: EnglishLocalization.password,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          autocorrect: false,
                          enableSuggestions: false,
                          obscureText: state.hidePassword,
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: BlocBuilder<LoginCubit, LoginState>(
                        buildWhen: (previous, current) => current.loadingState == LoadingState.loading,
                        builder: (context, state) {
                          return TextButton(
                            onPressed: state.loadingState == LoadingState.loading? null :() {
                              context.unFocusKeyboardFromScope();
                              Navigator.pushNamed(
                                  context, Routes.forgotPassword);
                            },
                            style: const ButtonStyle(),
                            child: Text(
                              EnglishLocalization.forgotPassword,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall, // was headlineSmall
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: kMinInteractiveDimension-8,
                      child: BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          switch (state.loadingState) {
                            case LoadingState.init:
                            case LoadingState.loaded:
                            case LoadingState.error:
                              return ElevatedButton(
                                onPressed: _login,
                                style: const ButtonStyle(
                                  minimumSize: MaterialStatePropertyAll<Size>(
                                    Size(double.infinity,
                                        kMinInteractiveDimension - 8),
                                  ),
                                ),
                                child: const Text(EnglishLocalization.login),
                              );
                            case LoadingState.loading:
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                          }
                        },
                      ),
                    ),
                    // Create an Account
                    Align(
                        alignment: Alignment.centerLeft,
                        child: BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return TextButton(
                              onPressed:
                                  state.loadingState == LoadingState.loading
                                      ? null
                                      : () {
                                          context.unFocusKeyboardFromScope();
                                          Navigator.pushNamed(
                                              context, Routes.signup);
                                        },
                              child: Text(
                                EnglishLocalization.dontHaveAnAccountRegister,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall, // was headlineSmall
                              ),
                            );
                          },
                        )),
                    const DividerWithCenteredText(),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return TextButton(
                              onPressed:
                                  state.loadingState == LoadingState.loading
                                      ? null
                                      : _guestLogin,
                              child: Text(
                                EnglishLocalization.loginAsGuest,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall, // was headlineSmall
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.unFocusKeyboardFromScope();
      LoginCubit.get(context)
          .login(LoginParams(_emailController.text, _passwordController.text));
    }
  }

  void _guestLogin(){
  context.unFocusKeyboardFromScope();
  LoginCubit.get(context).guestLogin();
}
}
