import 'package:chat_hive_ai/src/modules/home/providers/providers.dart';
import 'package:provider/single_child_widget.dart';

class HomeProvider {
  HomeProvider._();

  static List<SingleChildWidget> providers = [
    $FindAllChatsOfUserUsecaseProvider,
    $CreateNewChatUsecaseProvider,
    $DeleteChatUsecaseProvider,
    $UpdateChatUsecaseProvider,
    $ChatNotifier,
  ];
}
