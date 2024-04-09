import './barrel/auth_provider_barrel.dart';

class AuthProvider {
  AuthProvider._();
  static final List<SingleChildWidget> providers = [
    $SignInServiceProvider,
    $SignUpServiceProvider,
    $SignOutServiceProvider,
    $SignInGoogleServiceProvider,
    $SignOutGoogleServiceProvider,
    $SignInRepositoryProvider,
    $SignUpRepositoryProvider,
    $SignOutRepositoryProvider,
    $SignInGoogleRepositoryProvider,
    $SignOutGoogleRepositoryProvider,
    $SignInUsecaseProvider,
    $SignUpUsecaseProvider,
    $SignInGoogleUsecaseProvider,
    $AuthNotifierProvider,
  ];
}
