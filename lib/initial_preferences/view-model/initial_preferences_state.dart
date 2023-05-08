part of 'initial_preferences_cubit.dart';

class InitialPreferencesState extends Equatable {
  final String lang;
  final String region;
  final CacheState cacheState;
  final LoadingState loadingState;
  final void Function(Object?)? languageOnChanged;
  final void Function(Object?)? regionOnChanged;
  final bool allowDoneButton;
  final String message;

  const InitialPreferencesState({
    this.lang = 'English',
    this.region = 'EG',
    this.cacheState = CacheState.init,
    this.loadingState = LoadingState.init,
    this.languageOnChanged,
    this.regionOnChanged,
    this.allowDoneButton = true,
    this.message = '',
  });

  InitialPreferencesState copyWith({
    String? lang,
    String? region,
    CacheState? cacheState,
    LoadingState? loadingState,
    void Function(Object?)? languageOnChanged,
    void Function(Object?)? regionOnChanged,
    bool? allowDoneButton,
    String? message,
  }) {
    return InitialPreferencesState(
      lang: lang ?? this.lang,
      region: region ?? this.region,
      cacheState: cacheState ?? this.cacheState,
      loadingState: loadingState ?? this.loadingState,
      languageOnChanged: languageOnChanged ?? this.languageOnChanged,
      regionOnChanged: regionOnChanged ?? this.regionOnChanged,
      allowDoneButton: allowDoneButton ?? this.allowDoneButton,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        lang,
        region,
        cacheState,
        loadingState,
        languageOnChanged,
        regionOnChanged,
    allowDoneButton,
    message
      ];

  @override
  String toString() {
    return "runtimeType: $runtimeType lang: $lang, region: $region";
  }
}
