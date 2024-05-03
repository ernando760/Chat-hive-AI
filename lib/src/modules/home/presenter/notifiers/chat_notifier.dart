import 'dart:developer';

import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/adapters/chat_adapter.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/message_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/create_new_chat_usecase.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/delete_chat_usecase.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/find_all_chats_of_user_usecase.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/update_chat_usecase.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/notifiers/loading_notifier_mixin.dart';
import 'package:chat_hive_ai/src/shared/cache/app_cache.dart';
import 'package:chat_hive_ai/src/shared/env/env.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatNotifier extends ChangeNotifier
    with MessagesStateMixin, LoadingNotifierMixin {
  final FindAllChatsOfUserUsecase _findAllChatsOfUserUsecase;
  final CreateNewChatUsecase _createNewChatUsecase;
  final DeleteChatUsecase _deleteChatUsecase;
  final UpdateChatUsecase _updateChatUsecase;
  final _model = GenerativeModel(model: "gemini-pro", apiKey: Env.apiKey);
  final _cache = ChatCache();

  UserEntity? _user;
  List<ChatEntity> _chats = [];
  ChatEntity? _chatSelected;

  List<ChatEntity> get chats => _chats;
  ChatEntity? get chatSelected => _chatSelected;
  UserEntity? get user => _user;

  @override
  ChatNotifier(this._findAllChatsOfUserUsecase, this._createNewChatUsecase,
      this._deleteChatUsecase, this._updateChatUsecase) {
    _chatSelected = chats.isEmpty ? null : chats.last;
    Future(() async => await _cache.init());
  }

  void selectChat(ChatEntity chat) {
    if (_chatSelected == null) {
      _chatSelected = chat;
      notifyListeners();
      return;
    } else if (_chatSelected!.chatId != chat.chatId) {
      _chatSelected = chat;
      notifyListeners();
    }
  }

  void getUser(UserEntity? user) {
    _user = null;
    if (user != null) {
      _user = user;
      if (_chats.isNotEmpty) {
        selectChat(_chats.last);
      }
      return;
    }
    notifyListeners();
  }

  void removeUser() {
    if (_user != null) {
      _user = null;
      notifyListeners();
    }
  }

  Future<void> findAllChatOfUser({String? userId, int limit = 10}) async {
    setAppLoading(true);
    final chatsCache = _requestCache("chats") ?? [];
    if (chatsCache.isNotEmpty) {
      _chats = chatsCache.map((e) => ChatAdapter.fromMap(e)).toList();
      _chatSelected = _chats.last;
      await _syncronizeData(() async =>
          await _findAllChatsOfUserUsecase(userId: userId, limits: limit));
      setAppLoading(false);
      return;
    }

    final res = await _findAllChatsOfUserUsecase(userId: userId, limits: limit);

    switch (res) {
      case Success(:final success):
        _chats = success;
        if (_chats.isNotEmpty) {
          _chatSelected = _chats.last;
        }
        _cache.write("chats", _chats.map((e) => ChatAdapter.toMap(e)).toList());
        setAppLoading(false);
      case Failure(:final failure):
        showMessageError(failure.messageErro);
        setAppLoading(false);
    }
  }

  Future<void> createNewChat(
      {required String? userId, required String title}) async {
    setAppLoading(true);

    final res = await _createNewChatUsecase(userId: userId, title: title);
    switch (res) {
      case Success(:final success):
        _chats = success;
        _chatSelected = _chats.last;
        _cache.write("chats", _chats.map((e) => ChatAdapter.toMap(e)).toList());
        setAppLoading(false);
      case Failure(:final failure):
        showMessageError(failure.messageErro);
        setAppLoading(false);
    }
  }

  Future<void> deleteChat({required String? chatId}) async {
    setAppLoading(true);
    final res = await _deleteChatUsecase.call(chatId: chatId);
    switch (res) {
      case Success(:final success):
        _chats = success;
        _chatSelected = null;
        _cache.write("chats", _chats.map((e) => ChatAdapter.toMap(e)).toList());
        setAppLoading(false);
      case Failure(:final failure):
        showMessageError(failure.messageErro);
        setAppLoading(false);
    }
  }

  Future<void> renameChatTitle(
      {required String? chatId, required String title}) async {
    if (_chats.isNotEmpty) {
      setAppLoading(true);
      final newChat = _chats
          .firstWhere(
            (element) => element.chatId == chatId,
            orElse: () =>
                ChatEntity(chatId: chatId, title: title, messages: const []),
          )
          .copyWith(title: () => title);
      final res =
          await _updateChatUsecase.call(chatId: chatId, newChat: newChat);
      switch (res) {
        case Success(:final success):
          _chats = success;
          _cache.write(
              "chats", _chats.map((e) => ChatAdapter.toMap(e)).toList());
          setAppLoading(false);
        case Failure(:final failure):
          showMessageError(failure.messageErro);
          setAppLoading(false);
      }
    }
  }

  Future<void> sendMessage({required String message}) async {
    final meMessage = MessageEntity(
        id: "${DateTime.now().millisecondsSinceEpoch}",
        message: message,
        sender: MessageSender.me);

    final content = [Content.text(message)];

    _chatSelected = _chatSelected!
        .copyWith(messages: () => [..._chatSelected!.messages, meMessage]);

    setLoadingSendMessage(true);
    final resContent = await _model.generateContent(content);

    if (_chatSelected != null) {
      if (resContent.text != null) {
        final robotMessage = MessageEntity(
            id: "${DateTime.now().millisecondsSinceEpoch}",
            message: resContent.text!,
            sender: MessageSender.robot);

        _chatSelected = _chatSelected!.copyWith(
            messages: () => [..._chatSelected!.messages, robotMessage]);

        final res = await _updateChatUsecase.call(
            chatId: _chatSelected!.chatId, newChat: _chatSelected!);
        switch (res) {
          case Success(:final success):
            _chats = success;
            _cache.write(
                "chats", _chats.map((e) => ChatAdapter.toMap(e)).toList());
            setLoadingSendMessage(false);
          case Failure(:final failure):
            showMessageError(failure.messageErro);
            setAppLoading(false);
        }
      }
      log("$_chats", name: "CHATS");
    }
  }

  Future<void> removeMessage(
      {required ChatEntity chat, required String message}) async {
    setAppLoading(true);
    ChatEntity chatTemp;
    chat.messages.removeWhere((element) => element.message == message);
    chatTemp = chat;

    final res =
        await _updateChatUsecase.call(chatId: chat.chatId, newChat: chatTemp);
    switch (res) {
      case Success(:final success):
        _chats = success;
        _cache.write("chats", _chats.map((e) => ChatAdapter.toMap(e)).toList());
        setAppLoading(false);
      case Failure(:final failure):
        showMessageError(failure.messageErro);
        setAppLoading(false);
    }
  }

  List<Map<String, dynamic>>? _requestCache(
    String path,
  ) {
    final resCache = _cache.read(path);
    if (resCache != null) {
      return resCache;
    }
    return null;
  }

  Future<void> _syncronizeData(
      Future<Either<List<ChatEntity>, ExceptionBase>> Function()
          requestSycronize) async {
    final res = await requestSycronize();
    switch (res) {
      case Success(success: final chats):
        _chats = chats;
        _cache.write("chats", chats.map((e) => ChatAdapter.toMap(e)).toList());
      case _:
        showMessageError("Error ao fazer a sincronização!");
    }
  }
}
