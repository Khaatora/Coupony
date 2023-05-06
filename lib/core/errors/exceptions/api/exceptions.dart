import 'package:maslaha/core/errors/exceptions/server_exception.dart';

import '../../../global/localization.dart';

class GenericAPIException extends ServerException{

  const GenericAPIException([super.message = EnglishLocalization.genericErrorMessage]);
}

class NoInternetException extends ServerException{

  const NoInternetException([super.message = EnglishLocalization.noInternetErrorMessage]);
}

class MissingTokenException extends ServerException{

  const MissingTokenException([super.message = EnglishLocalization.missingTokenErrorMessage]);
}
class ExpiredTokenException extends ServerException{

  const ExpiredTokenException([super.message = EnglishLocalization.expiredTokenErrorMessage]);
}
class InvalidTokenException extends ServerException{

  const InvalidTokenException([super.message = EnglishLocalization.invalidTokenErrorMessage]);
}