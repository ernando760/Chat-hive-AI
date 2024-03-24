import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class IsUserLoggedException extends ExceptionBase {
  IsUserLoggedException(
      {required super.label, required super.messageErro, super.stackTrace});
}

class IsUserLoggedServicesException extends IsUserLoggedException {
  IsUserLoggedServicesException(
      {required super.label, required super.messageErro, super.stackTrace});
}
