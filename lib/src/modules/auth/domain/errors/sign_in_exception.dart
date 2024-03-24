import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class SignInException extends ExceptionBase {
  SignInException(
      {required super.label, required super.messageErro, super.stackTrace});
}

class SignInRepositoryException extends SignInException {
  SignInRepositoryException(
      {required super.label, required super.messageErro, super.stackTrace});
}

class SignInUsecaseException extends SignInException {
  SignInUsecaseException(
      {required super.label, required super.messageErro, super.stackTrace});
}

class SignInGoogleRepositoryException extends SignInException {
  SignInGoogleRepositoryException(
      {required super.label, required super.messageErro, super.stackTrace});
}

class SignInGoogleUsecaseException extends SignInException {
  SignInGoogleUsecaseException(
      {required super.label, required super.messageErro, super.stackTrace});
}

class SignInServiceException extends SignInException {
  SignInServiceException(
      {required super.label, required super.messageErro, super.stackTrace});
}
