import 'package:dartz/dartz.dart';
import 'package:maslaha/core/MVVM/model/remote/task_data_model.dart';

import '../../errors/failures/IFailures.dart';

abstract class GetTaskDataRepository {
  Future<Either<IFailure, TaskDataModel>> getTasks();
}
