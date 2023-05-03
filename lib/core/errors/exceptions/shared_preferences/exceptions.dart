import 'package:maslaha/core/errors/exceptions/cache_exception.dart';

import '../../../global/localization.dart';

class GenericSharedPrefsException extends CacheException{

  const GenericSharedPrefsException([super.message = EnglishLocalization.genericErrorMessage]);
}