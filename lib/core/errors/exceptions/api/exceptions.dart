import 'package:maslaha/core/errors/exceptions/cache_exception.dart';

import '../../../global/localization.dart';

class GenericAPIException extends CacheException{

  const GenericAPIException([super.message = EnglishLocalization.genericErrorMessage]);
}