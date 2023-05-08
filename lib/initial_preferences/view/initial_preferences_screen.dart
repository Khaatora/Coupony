import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/global/localization.dart';
import 'package:maslaha/initial_preferences/view-model/initial_preferences_cubit.dart';

import '../../core/componets/custom_labeled_drop_down_button_form_field.dart';
import '../../core/constants/routes.dart';
import '../../core/global/colors.dart';
import '../../core/services/services_locator.dart';
import '../../core/utils/enums/loading_enums.dart';

class InitialPreferencesScreen extends StatelessWidget {
  const InitialPreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<InitialPreferencesCubit>()..init(),
      child: const InitialPreferencesView(),
    );
  }
}

class InitialPreferencesView extends StatefulWidget {
  const InitialPreferencesView({Key? key}) : super(key: key);

  @override
  State<InitialPreferencesView> createState() => _InitialPreferencesViewState();
}

class _InitialPreferencesViewState extends State<InitialPreferencesView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(8),
        child: BlocListener<InitialPreferencesCubit, InitialPreferencesState>(
          listener: (context, state) {
            switch (state.loadingState) {
              case LoadingState.init:
              case LoadingState.loading:
                break;
              case LoadingState.loaded:
                Navigator.pushReplacementNamed(context, Routes.login);
                break;
              case LoadingState.error:
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
                break;
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    EnglishLocalization.pleaseChooseYourLocationAndLanguage,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                BlocBuilder<InitialPreferencesCubit, InitialPreferencesState>(
                  buildWhen: (previous, current) =>
                      previous.lang != current.lang ||
                      previous.languageOnChanged != current.languageOnChanged,
                  builder: (context, state) {
                    return CustomLabeledDropDownButtonFormField<String>(
                      onChanged: state.languageOnChanged,
                      items: InitialPreferencesCubit.languages,
                      value: state.lang,
                      label: EnglishLocalization.language,
                      textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColor.black
                      ),
                    );
                    // return DropdownButtonFormField(
                    //   value: state.lang,
                    //   items: InitialPreferencesCubit.languages
                    //       .map((language) =>
                    //       DropdownMenuItem<String>(
                    //           value: language,
                    //           child: Text(
                    //             language,
                    //             style: Theme
                    //                 .of(context)
                    //                 .textTheme
                    //                 .displaySmall,
                    //           )))
                    //       .toList(),
                    //   onChanged: (lang) {
                    //     InitialPreferencesCubit.get(context).setLanguage(lang!);
                    //   },
                    // );
                  },
                ),
                const Expanded(flex: 1, child: SizedBox()),
                // const Text(EnglishLocalization.region),
                // DropdownButtonFormField(
                //   value: state.region,
                //   items: InitialPreferencesCubit.regions
                //       .map((region) => DropdownMenuItem<String>(
                //       value: region,
                //       child: Text(
                //         region,
                //         style: Theme.of(context).textTheme.displaySmall,
                //       )))
                //       .toList(),
                //   onChanged: (region) {
                //     InitialPreferencesCubit.get(context).setRegions(region!);
                //   },
                // ),
                BlocBuilder<InitialPreferencesCubit, InitialPreferencesState>(
                  buildWhen: (previous, current) =>
                      previous.region != current.region ||
                      previous.regionOnChanged != current.regionOnChanged,
                  builder: (context, state) {
                    return CustomLabeledDropDownButtonFormField<String>(
                      onChanged: state.regionOnChanged,
                      items: InitialPreferencesCubit.regions,
                      value: state.region,
                      label: EnglishLocalization.region,
                      textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColor.black,
                      ),
                    );
                  },
                ),
                const Expanded(flex: 5, child: SizedBox()),
                const SizedBox(
                  width: double.infinity,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                BlocBuilder<InitialPreferencesCubit,
                    InitialPreferencesState>(
                  buildWhen: (previous, current) =>
                      previous.allowDoneButton != current.allowDoneButton,
                  builder: (context, state) {
                    log("${state.allowDoneButton}");
                    return SizedBox(
                      height: 60,
                      child: Center(child: state.allowDoneButton
                          ? ElevatedButton(
                          onPressed: _validateFormAndSendData,
                        style: const ButtonStyle(
                          minimumSize: MaterialStatePropertyAll<Size>(
                            Size(double.infinity, kMinInteractiveDimension),
                          ),
                        ),
                          child: const Text(EnglishLocalization.done),)
                          : const CircularProgressIndicator(),),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateFormAndSendData() {
    if (_formKey.currentState!.validate()) {
      sl<InitialPreferencesCubit>().cacheData();
    }
  }
}
