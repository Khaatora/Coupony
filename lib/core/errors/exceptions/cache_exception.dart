import '../../global/localization.dart';

class CacheException implements Exception{
  final String message;
  // create your own Exception and extend this class if you want to throw an Exception
  const CacheException([this.message = EnglishLocalization.genericErrorMessage]);
}