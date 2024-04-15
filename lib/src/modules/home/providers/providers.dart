import 'package:chat_hive_ai/src/modules/home/domain/usecases/create_new_chat_usecase.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/delete_chat_usecase.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/find_all_chats_of_user_usecase.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/update_chat_usecase.dart';
import 'package:chat_hive_ai/src/modules/home/infra/repositories/firebase/firebase_create_new_chat_repository_impl.dart';
import 'package:chat_hive_ai/src/modules/home/infra/repositories/firebase/firebase_delete_chat_repository_impl.dart';
import 'package:chat_hive_ai/src/modules/home/infra/repositories/firebase/firebase_find_all_chats_of_user_repository_impl.dart';
import 'package:chat_hive_ai/src/modules/home/infra/repositories/firebase/firebase_update_chat_repository_impl.dart';
import 'package:provider/provider.dart';

final $FindAllChatsOfUserUsecaseProvider = Provider(
    create: (context) =>
        FindAllChatsOfUserUsecase(FirebaseFindAllChatsOfUserRepositoryImpl()));

final $CreateNewChatUsecaseProvider = Provider(
    create: (context) =>
        CreateNewChatUsecase(FirebaseCreateNewChatRepositoryImpl()));

final $DeleteChatUsecaseProvider = Provider(
    create: (context) => DeleteChatUsecase(FirebaseDeleteChatRepositoryImpl()));

final $UpdateChatUsecaseProvider = Provider(
    create: (context) => UpdateChatUsecase(FirebaseUpdateChatRepositoryImpl()));
