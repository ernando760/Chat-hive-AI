import 'package:chat_hive_ai/src/modules/auth/domain/usecase/is_user_logged_usecase.dart';
import 'package:chat_hive_ai/src/modules/auth/infra/repositories/is_login_logged_repository_impl.dart';
import 'package:chat_hive_ai/src/modules/auth/infra/services/firebase/firebase_is_user_logged_service_impl.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/screens/splash/notifier/splash_notifier.dart';
import 'package:provider/single_child_widget.dart';

class SplashProvider {
  SplashProvider._();
  static final List<SingleChildWidget> providers = [
    $IsUserLoggedServiceProvider,
    $IsUserLoggedRepositoryProvider,
    $IsUserLoggedUsecaseProvider,
    $SplashNotifier,
  ];
}
