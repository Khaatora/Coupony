import 'package:maslaha/core/errors/exceptions/server_exception.dart';

import '../../../global/localization.dart';

class GenericAPIException extends ServerException{

  const GenericAPIException([super.message = EnglishLocalization.genericErrorMessage]);
}

class InternetDisconnectedException extends ServerException{

  const InternetDisconnectedException([super.message = EnglishLocalization.noInternetErrorMessage]);
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
class InvalidCredentialsException extends ServerException{

  const InvalidCredentialsException([super.message = EnglishLocalization.invalidCredentialsErrorMessage]);
}
class IncorrectVerificationCodeException extends ServerException{

  const IncorrectVerificationCodeException([super.message = EnglishLocalization.incorrectVerificationCodeErrorMessage]);
}
class EmailAlreadyInUseException extends ServerException{

  const EmailAlreadyInUseException([super.message = EnglishLocalization.incorrectVerificationCodeErrorMessage]);
}
class SessionExpiredException extends ServerException{

  const SessionExpiredException([super.message = EnglishLocalization.incorrectVerificationCodeErrorMessage]);
}
class InvalidEmailException extends ServerException{

  const InvalidEmailException([super.message = EnglishLocalization.invalidEmailErrorMessage]);
}
class SessionNotVerifiedException extends ServerException{

  const SessionNotVerifiedException([super.message = EnglishLocalization.sessionNotVerifiedErrorMessage]);
}
class PasswordAlreadyUsedException extends ServerException{

  const PasswordAlreadyUsedException([super.message = EnglishLocalization.passwordAlreadyUsedErrorMessage]);
}
