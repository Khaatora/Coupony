import 'package:equatable/equatable.dart';
import 'package:maslaha/core/utils/enums/cache_enums.dart';
import 'package:maslaha/core/utils/enums/token_enums.dart';

class AppStateModel extends Equatable{
  final CacheState cacheState;
  final TokenState tokenState;

  const AppStateModel({required this.cacheState, required this.tokenState});

  @override
  List<Object?> get props => [cacheState, tokenState,];


}