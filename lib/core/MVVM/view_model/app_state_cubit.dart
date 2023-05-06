import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maslaha/core/MVVM/model/app_state_model.dart';
import 'package:maslaha/core/utils/enums/loading_enums.dart';

import '../../utils/enums/cache_enums.dart';
import '../../utils/enums/token_enums.dart';
import '../repository/i_token_verification_repository.dart';

part 'app_state_state.dart';

class AppStateCubit extends Cubit<AppState> {
  final ITokenVerificationRepository repository;

  AppStateCubit(this.repository) : super(const AppState());

  Future<void> getAppState() async {
    final result = await repository.validateToken();
    result.fold((l) {
      emit(state.copyWith(
        appStateModel: const AppStateModel(
            cacheState: CacheState.init, tokenState: TokenState.init),
        loadingState: LoadingState.error,
        message: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        appStateModel: AppStateModel(
          cacheState: r.cacheState,
          tokenState: r.tokenState,
        ),
        loadingState: LoadingState.loaded,
      ));
    });
  }
}
