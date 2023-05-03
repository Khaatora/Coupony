import 'IFailures.dart';

/// Cache Failure for returning cache exceptions as a CacheFailure object
class CacheFailure extends IFailure{
  const CacheFailure(super.message);

}