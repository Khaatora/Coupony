import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maslaha/core/utils/enums/cache_enums.dart';
import 'package:maslaha/core/utils/enums/loading_enums.dart';
import 'package:maslaha/core/home_layout/model/user_data_params.dart';

import '../repository/i_initial_preferences_repository.dart';

part 'initial_preferences_state.dart';

class InitialPreferencesCubit extends Cubit<InitialPreferencesState> {
  final IInitialPreferencesRepository _repository;

  InitialPreferencesCubit(this._repository)
      : super(const InitialPreferencesState());

  void setLanguage(String lang) {
    emit(state.copyWith(lang: lang));
  }

  static InitialPreferencesCubit get(context) =>
      BlocProvider.of<InitialPreferencesCubit>(context);

  static List<String> get languages => ["Arabic", "English"];

  static List<String> get regions => ["GCC", "EG"];


  void setRegions(String region) {
    emit(state.copyWith(region: region));
  }

  void init() {
    emit(state.copyWith(
        regionOnChanged: _regionOnChanged,
        languageOnChanged: _languageOnChanged));
  }

  Future<void> cacheData() async {
    emit(state.copyWith(
      cacheState: CacheState.init,
      loadingState: LoadingState.loading,
      allowDoneButton: false,
    ));
    log(state.toString());
    final result = await _repository
        .cacheData(UserSettingsParams(lang: state.lang, region: state.region));

    result.fold(
        (l) => emit(state.copyWith(
            cacheState: CacheState.init,
            loadingState: LoadingState.error,
            allowDoneButton: true,
            languageOnChanged: _languageOnChanged,
            regionOnChanged: _regionOnChanged,
            message: l.message)),
        (r) => emit(state.copyWith(
              loadingState: LoadingState.loaded,
              cacheState: CacheState.exists,
            )));
  }

  Future<void> getCachedData() async {
    emit(state.copyWith(
      cacheState: CacheState.init,
      loadingState: LoadingState.loading,
    ));

    final result = await _repository.getCachedData();

    result.fold(
        (l) => emit(state.copyWith(
            cacheState: CacheState.init, loadingState: LoadingState.error)),
        (r) => emit(state.copyWith(
              loadingState: LoadingState.loaded,
              cacheState: CacheState.exists,
            )));
  }

  void _languageOnChanged(lang) {
    setLanguage(lang!);
  }

  void _regionOnChanged(region) {
    setRegions(region!);
  }
}
