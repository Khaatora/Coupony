import 'package:dartz/dartz.dart';
import 'package:maslaha/core/MVVM/model/app_state_model.dart';
import '../../errors/failures/IFailures.dart';

abstract class ITokenVerificationRepository{

  Future<Either<IFailure, AppStateModel>> validateToken();

}
