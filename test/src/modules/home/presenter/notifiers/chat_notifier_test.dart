import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/create_new_chat_usecase.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/delete_chat_usecase.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/find_all_chats_of_user_usecase.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/update_chat_usecase.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/notifiers/chat_notifier.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mocks.dart';

class MockFindAllChatsOfUserUsecase extends Mock
    implements FindAllChatsOfUserUsecase {}

class MockCreateNewChatUsecase extends Mock implements CreateNewChatUsecase {}

class MockDeleteChatUsecase extends Mock implements DeleteChatUsecase {}

class MockUpdateChatUsecase extends Mock implements UpdateChatUsecase {}

class FakeChatEntity extends Fake implements ChatEntity {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeChatEntity());
  });
  final mockFindAllChatOfusecase = MockFindAllChatsOfUserUsecase();
  final mockCreateNewChatUsecase = MockCreateNewChatUsecase();
  final mockDeleteChatUsecase = MockDeleteChatUsecase();
  final mockUpdateChatUsecase = MockUpdateChatUsecase();
  final chatNotifier = ChatNotifier(mockFindAllChatOfusecase,
      mockCreateNewChatUsecase, mockDeleteChatUsecase, mockUpdateChatUsecase);

  List<ChatEntity> mockUpdateChat(String chatId, String value) {
    return chatNotifier.chats.map((e) {
      if (e.chatId != "chat11") {
        return e;
      }
      return e = e.copyWith(title: () => value);
    }).toList();
  }

  group("Success Test =>", () {
    test(
        "Deve encontrar todas as conversas do usuario quando chamar o método [chatNotifier.findAllChatOfUser].",
        () async {
      when(
        () => mockFindAllChatOfusecase(userId: "userId"),
      ).thenAnswer((_) async => Success(chats));
      await chatNotifier.findAllChatOfUser(userId: "userId");

      expect(chatNotifier.chats.length, equals(chats.length));
      verify(
        () => mockFindAllChatOfusecase(userId: "userId"),
      ).called(1);
    });

    test(
        "Deve criar uma nova conversa quando chamar o método [chatNotifier.createNewChat].",
        () async {
      final chat =
          ChatEntity(chatId: "chatId", title: "testando", messages: messages);
      when(() => mockCreateNewChatUsecase(
              userId: any(named: "userId"), title: "testando"))
          .thenAnswer((_) async => Success([...chats, chat]));

      await chatNotifier.createNewChat(userId: "userId", title: "testando");

      expect(
          chatNotifier.chats
              .firstWhere((element) => element.chatId == chat.chatId)
              .title,
          equals("testando"));
      expect(chatNotifier.chats.length, equals(11));
      verify(
        () => mockCreateNewChatUsecase(
            userId: any(named: "userId"), title: "testando"),
      ).called(1);
    });

    test(
        "Deve Deletar a conversa quando chamar o método [chatNotifier.deleteChat].",
        () async {
      final deleteChat =
          chats.where((element) => element.chatId != "chat5").toList();
      when(() => mockDeleteChatUsecase(chatId: "chat5"))
          .thenAnswer((_) async => Success(deleteChat));

      await chatNotifier.deleteChat(chatId: "chat5");

      expect(chatNotifier.chats.length, equals(9));
      verify(
        () => mockDeleteChatUsecase(chatId: "chat5"),
      ).called(1);
    });
    test(
        "Deve renomear o titulo da conversa quando chamar o método [chatNotifier.renameChatTitle].",
        () async {
      when(
        () => mockCreateNewChatUsecase(
            userId: any(named: "userId"), title: "title11"),
      ).thenAnswer((_) async => Success([
            ...chats,
            ChatEntity(chatId: "chat11", title: "title11", messages: messages)
          ]));
      await chatNotifier.createNewChat(userId: "userId", title: "title11");
      final updateChat = mockUpdateChat("chat11", "atualizando o titulo");

      when(() => mockUpdateChatUsecase(
          chatId: "chat11",
          newChat: chatNotifier.chats
              .firstWhere((element) => element.chatId == "chat11")
              .copyWith(
                title: () => "atualizando o titulo",
              ))).thenAnswer((_) async => Success(updateChat));

      await chatNotifier.renameChatTitle(
          chatId: "chat11", title: "atualizando o titulo");

      expect(chatNotifier.chats.length, equals(11));
      expect(
          chatNotifier.chats
              .firstWhere((element) => element.chatId == "chat11")
              .title,
          "atualizando o titulo");
      verify(
        () => mockUpdateChatUsecase(
            chatId: "chat11",
            newChat: chatNotifier.chats
                .firstWhere((element) => element.chatId == "chat11")
                .copyWith(
                  title: () => "atualizando o titulo",
                )),
      ).called(1);
    });
  });

  group("Failure Test =>", () {
    test(
        "Deve retornar um exceção FindAllChatOfUserException com uma messagem de error 'O id do usuário está vazio.' quando chamar o metodo [chatNotifier.findAllChatOfUser]",
        () async {
      when(() => mockFindAllChatOfusecase(userId: null)).thenAnswer((_) async =>
          Failure(FindAllChatsException(
              label: "MockFindAllChatsOfUserUsecase",
              messageErro: "O id do usuário está vazio.")));

      await chatNotifier.findAllChatOfUser(userId: null);

      expect(chatNotifier.message, equals("O id do usuário está vazio."));
      expect(chatNotifier.message, isNotNull);
    });

    test(
        "Deve retornar um exceção CreateNewChatException com uma messagem de error 'O id do usuário está vazio.' quando chamar o metodo [chatNotifier.createNewChat]",
        () async {
      when(() => mockCreateNewChatUsecase(userId: null, title: "new title"))
          .thenAnswer((_) async => Failure(CreateNewChatException(
              label: "MockCreateNewChatUsecase",
              messageErro: "O id do usuário está vazio.")));

      await chatNotifier.createNewChat(userId: null, title: "new title");
      expect(chatNotifier.message, equals("O id do usuário está vazio."));
      expect(chatNotifier.message, isNotNull);
    });
    test(
        "Deve retornar um exceção CreateNewChatException com uma messagem de error 'O título está vazio.' quando chamar o metodo [chatNotifier.createNewChat]",
        () async {
      when(() =>
              mockCreateNewChatUsecase(userId: any(named: "userId"), title: ""))
          .thenAnswer((_) async => Failure(CreateNewChatException(
              label: "MockCreateNewChatUsecase",
              messageErro: "O título está vazio.")));

      await chatNotifier.createNewChat(userId: "userId", title: "");

      expect(chatNotifier.message, equals("O título está vazio."));
      expect(chatNotifier.message, isNotNull);
    });

    test(
        "Deve retornar um exceção DeleteChatException com uma messagem de error 'O id da conversa está vazio.' quando chamar o metodo [chatNotifier.deleteChat]",
        () async {
      when(() => mockDeleteChatUsecase(chatId: null)).thenAnswer((_) async =>
          Failure(DeleteChatException(
              label: "MockDeleteChatUsecase",
              messageErro: "O id da conversa está vazio.")));

      await chatNotifier.deleteChat(chatId: null);

      expect(chatNotifier.message, equals("O id da conversa está vazio."));
      expect(chatNotifier.message, isNotNull);
    });

    test(
        "Deve retornar um exceção UpdateChatException com uma messagem de error 'O id da conversa está vazio.' quando chamar o metodo [chatNotifier.deleteChat]",
        () async {
      when(() => mockFindAllChatOfusecase(userId: any(named: "userId")))
          .thenAnswer((_) async => Success(chats));

      await chatNotifier.findAllChatOfUser(userId: "userId");

      when(() =>
              mockUpdateChatUsecase(chatId: "", newChat: any(named: "newChat")))
          .thenAnswer((_) async => Failure(UpdateChatException(
              label: "MockUpdateChatUsecase",
              messageErro: "O id da conversa está vazio.")));

      await chatNotifier.renameChatTitle(chatId: "", title: "atualizando");

      expect(chatNotifier.message, equals("O id da conversa está vazio."));
      expect(chatNotifier.message, isNotNull);
    });

    test(
        "Deve retornar um exceção UpdateChatException com uma messagem de error 'O titulo não pode está vazio.' quando chamar o metodo [chatNotifier.deleteChat]",
        () async {
      when(() => mockFindAllChatOfusecase(userId: any(named: "userId")))
          .thenAnswer((_) async => Success(chats));

      await chatNotifier.findAllChatOfUser(userId: "userId");

      when(() => mockUpdateChatUsecase(
              chatId: "chat5", newChat: newChat.copyWith(title: () => "")))
          .thenAnswer((_) async => Failure(UpdateChatException(
              label: "MockUpdateChatUsecase",
              messageErro: "O titulo não pode está vazio.")));

      await chatNotifier.renameChatTitle(chatId: "chat5", title: "");

      expect(chatNotifier.message, equals("O titulo não pode está vazio."));
      expect(chatNotifier.message, isNotNull);
    });
  });
}
