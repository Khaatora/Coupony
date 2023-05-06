part of 'app_state_cubit.dart';

class AppState extends Equatable {
  final String message;
  final LoadingState loadingState;
  final AppStateModel appStateModel;

  const AppState(
      {this.message = '',
      this.loadingState = LoadingState.init,
      this.appStateModel = const AppStateModel(
          cacheState: CacheState.init, tokenState: TokenState.init)});

  AppState copyWith({
    AppStateModel? appStateModel,
    String? message,
    LoadingState? loadingState,
  }) {
    return AppState(
      appStateModel: appStateModel ?? this.appStateModel,
      message: message ?? this.message,
      loadingState: loadingState ?? this.loadingState,
    );
  }

  @override
  List<Object> get props => [
        message,
        loadingState,
        appStateModel,
      ];
}
