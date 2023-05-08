import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maslaha/core/constants/routes.dart';
import 'package:maslaha/core/global/localization.dart';
import 'package:maslaha/core/global/size_config.dart';
import 'package:maslaha/core/utils/general_utils.dart';
import 'package:maslaha/sign_up/view_model/signup_cubit.dart';

import '../../core/MVVM/view_model/ui_view_model/ui_cubit.dart';
import '../../core/componets/custom_labeled_drop_down_button_form_field.dart';
import '../../core/componets/labeled_text_form_field_wtih_trailing.dart';
import '../../core/global/colors.dart';
import '../../core/services/services_locator.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => sl<SignupCubit>(),
      ),
      BlocProvider(
        create: (context) => sl<UiCubit>(),
      )
    ], child: const SignupView());
  }
}

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late PageController _pageController;

  // signup
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _genderController;
  late TextEditingController _dobController;
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  //verifyCode
  late TextEditingController _codeController;
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _genderController = TextEditingController();
    _dobController = TextEditingController();
    _pageController = PageController();
    _codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //TODO: error handling
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              height: SizeConfig.safeBlockVertical * 100,
              width: SizeConfig.safeBlockHorizontal * 100,
              padding: const EdgeInsets.all(16),
              child: BlocListener<SignupCubit, SignupState>(
                listener: (context, state) {
                  switch (state.signUpState) {
                    case SignUpState.init:
                      _pageBack();
                      break;
                    case SignUpState.awaitingCode:
                      context.showCustomSnackBar(
                          EnglishLocalization.awaitingCode,
                          const Duration(seconds: 1, milliseconds: 500));
                      break;
                    case SignUpState.awaitingUserInput:
                      _pageForward();
                      break;
                    case SignUpState.verifyingCode:
                      context.showCustomSnackBar(
                          EnglishLocalization.verifyingCode,
                          const Duration(seconds: 1, milliseconds: 500));
                      break;
                    case SignUpState.finishingUp:
                      context.showCustomSnackBar(
                          EnglishLocalization.finishingUp,
                          const Duration(seconds: 1, milliseconds: 500));
                      break;
                    case SignUpState.success:
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.home, (route) => false);
                      break;
                    case SignUpState.error:
                      context.showCustomSnackBar(state.message,const Duration(seconds: 4), AppColor.red);
                      break;
                  }
                },
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Form(
                      key: _formKey1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                EnglishLocalization.signup,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
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
                            buildWhen: (previous, current) =>
                                current.hidePassword != previous.hidePassword,
                            builder: (context, state) {
                              return LabeledTextFormFieldWithTrailing(
                                textEditingController: _passwordController,
                                trailing: Container(
                                  padding: const EdgeInsets.all(0),
                                  width: 30,
                                  child: IconButton(
                                    onPressed: () {
                                      UiCubit.get(context)
                                          .changePasswordVisibility();
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
                                      (password.length < 6 ||
                                          password.length > 18)) {
                                    return EnglishLocalization
                                        .enterValidPassword;
                                  }
                                  return null;
                                },
                                hintText: EnglishLocalization.password,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.visiblePassword,
                                autocorrect: false,
                                enableSuggestions: false,
                                obscureText: state.hidePassword,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<UiCubit, UIState>(
                            buildWhen: (previous, current) =>
                                current.hidePassword != previous.hidePassword,
                            builder: (context, state) {
                              return LabeledTextFormFieldWithTrailing(
                                textEditingController:
                                    _confirmPasswordController,
                                validator: (password) {
                                  if (password != _passwordController.text) {
                                    return EnglishLocalization
                                        .passwordsDoNotMatch;
                                  }
                                  return null;
                                },
                                hintText: EnglishLocalization.confirmPassword,
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.visiblePassword,
                                autocorrect: false,
                                enableSuggestions: false,
                                obscureText: state.hidePassword,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          LabeledTextFormFieldWithTrailing(
                            textEditingController: _dobController,
                            validator: _dobValidator,
                            hintText: EnglishLocalization.dob,
                            trailing: IconButton(
                              onPressed: () {
                                _showDPicker(context);
                              },
                              icon: const Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
                            onTap: () {
                              _showDPicker(context);
                            },
                          ),
                          // TextFormField(
                          //   controller: _dobController,
                          //   decoration: InputDecoration(
                          //     labelText: EnglishLocalization.dob,
                          //     labelStyle: Theme.of(context).textTheme.titleMedium,
                          //     suffixIcon: IconButton(
                          //       onPressed: () {
                          //         _showDPicker(context);
                          //       },
                          //       icon: const Icon(Icons.calendar_today),
                          //     ),
                          //   ),
                          //   readOnly: true,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return EnglishLocalization.enterValidDob;
                          //     }
                          //     return null;
                          //   },
                          //   onTap: () {
                          //     _showDPicker(context);
                          //   },
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<SignupCubit, SignupState>(
                            buildWhen: (previous, current) =>
                                previous.gender != current.gender,
                            builder: (context, state) {
                              return CustomLabeledDropDownButtonFormField<
                                  String>(
                                value: state.gender,
                                items: SignupCubit.gender,
                                textStyle: const TextStyle(
                                  color: Colors.red
                                ),
                                onChanged: _genderOnChanged,
                                selectedItemBuilder: (context) {
                                  return SignupCubit.gender
                                      .map<Widget>((gender) {
                                    return Text(
                                      gender,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: AppColor.black),
                                    );
                                  }).toList();
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: kMinInteractiveDimension - 8,
                            child: BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                switch (state.signUpState) {
                                  case SignUpState.awaitingCode:
                                    return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  case SignUpState.init:
                                  case SignUpState.awaitingUserInput:
                                  case SignUpState.verifyingCode:
                                  case SignUpState.finishingUp:
                                  case SignUpState.success:
                                  case SignUpState.error:
                                    return ElevatedButton(
                                        onPressed: _signUp,
                                        style: const ButtonStyle(
                                          minimumSize:
                                              MaterialStatePropertyAll<Size>(
                                            Size(double.infinity,
                                                kMinInteractiveDimension - 8),
                                          ),
                                        ),
                                        child: const Text(
                                            EnglishLocalization.signup));
                                }
                              },
                            ),
                          ),
                          // Create an Account
                          Align(
                            alignment: Alignment.centerLeft,
                              child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              EnglishLocalization.alreadyHaveAnAccountLogin,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          )),
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: BlocBuilder<SignupCubit, SignupState>(
                              buildWhen: (previous, current) =>
                                  current.signUpState ==
                                  SignUpState.awaitingUserInput,
                              builder: (context, state) {
                                return Text(
                                  "${EnglishLocalization.enterCodeSentTo}\n${state.email}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                );
                              },
                            ),
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
                          //TODO: ask zero about code receive/resend
                          // ElevatedButton(
                          //     onPressed: () {},
                          //     style: Theme
                          //         .of(context)
                          //         .elevatedButtonTheme
                          //         .style
                          //         ?.copyWith(
                          //         backgroundColor:
                          //         const MaterialStatePropertyAll<Color>(
                          //             Colors.black12),
                          //         foregroundColor:
                          //         const MaterialStatePropertyAll<Color>(
                          //             Colors.black),
                          //         overlayColor:
                          //         const MaterialStatePropertyAll<Color>(
                          //             Colors.black12),
                          //         textStyle: MaterialStatePropertyAll(
                          //             Theme
                          //                 .of(context)
                          //                 .textTheme
                          //                 .bodySmall)),
                          //     child: const Text(
                          //         EnglishLocalization.iDidntReceiveCode)),
                          const Expanded(flex: 7, child: SizedBox()),
                          BlocBuilder<SignupCubit, SignupState>(
                            buildWhen: (previous, current) =>
                                (current.signUpState ==
                                        SignUpState.awaitingUserInput ||
                                    current.signUpState == SignUpState.error ||
                                    current.signUpState ==
                                        SignUpState.verifyingCode),
                            builder: (context, state) {
                              switch (state.signUpState) {
                                case SignUpState.init:
                                case SignUpState.awaitingCode:
                                case SignUpState.awaitingUserInput:
                                case SignUpState.error:
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          SignupCubit.get(context).reInit();
                                          _pageController.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.fastOutSlowIn);
                                        },
                                        icon: const Icon(Icons.arrow_back),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  AppColor.primaryColor),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: _verifyCode,
                                        child: const Text(
                                            EnglishLocalization.confirmCode),
                                      ),
                                    ],
                                  );
                                case SignUpState.verifyingCode:
                                case SignUpState.finishingUp:
                                case SignUpState.success:
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  void _genderOnChanged(Object? gender) {
    SignupCubit.get(context).setGender(gender as String);
  }

  void _pageBack() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  void _pageForward() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  String? _dobValidator(String? value) {
    if (value == null || value.isEmpty) {
      return EnglishLocalization.enterValidDob;
    }
    return null;
  }

  //showDatePicker
  void _showDPicker(BuildContext context) async {
    context.unFocusKeyboardFromScope();
    await showDatePicker(
            context: context,
            initialDate: SignupCubit.get(context).state.dob ??
                DateTime.now().subtract(const Duration(days: 365 * 6)),
            firstDate: DateTime.now().subtract(const Duration(days: 365 * 150)),
            lastDate: DateTime.now().subtract(const Duration(days: 365 * 6)))
        .then((chosenDate) {
      if (chosenDate != null) {
        _dobController.text = DateFormat('yyyy-MM-dd').format(chosenDate);
        SignupCubit.get(context).setDob(chosenDate);
      }
    });
  }

  void _signUp() async {
    if (_formKey1.currentState!.validate()) {
      await SignupCubit.get(context).verifyEmail(
          _emailController.text,
          _passwordController.text,
          _dobController.text,
          _genderController.text);
    }
  }

  String? _codeValidator(String? value) {
    if (value == null || value.isEmpty || value.length != 6) {
      return EnglishLocalization.enterValidCode;
    }
    return null;
  }

  void _verifyCode() {
    if (_formKey2.currentState!.validate()) {
      SignupCubit.get(context)
          .verifyCode(_codeController.text)
          .then((value) => SignupCubit.get(context).signUp());
    }
  }
}
