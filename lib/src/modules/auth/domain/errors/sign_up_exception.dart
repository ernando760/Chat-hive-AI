import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class SignUpException extends ExceptionBase {
  SignUpException(
      {required super.label, required super.messageErro, super.stackTrace});
}

class SignUpRepositoryException extends SignUpException {
  SignUpRepositoryException(
      {required super.label, required super.messageErro, super.stackTrace});
}

class SignUpUsecaseException extends SignUpException {
  SignUpUsecaseException(
      {required super.label, required super.messageErro, super.stackTrace});
}

class SignUpServiceException extends SignUpException {
  SignUpServiceException(
      {required super.label, required super.messageErro, super.stackTrace});
}
