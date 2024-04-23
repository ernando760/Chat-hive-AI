import 'dart:async';
import 'package:hive/hive.dart';

abstract class AppCache {
  Future<void> init();
  Future<void> close();
  T? read<T>(String path);
  void write<T>(String path, T data);
  void delete(String path);
}

class ChatCache implements AppCache {
  static final _instance = ChatCache._internal();

  ChatCache._internal();

  factory ChatCache.init() {
    return _instance;
  }
//  late final Box<T> _box;
  factory ChatCache() {
    return _instance;
  }

  @override
  T? read<T>(String path) {
    T? value;
    Hive.openBox("chats").then((box) async {
      final chatsBox = box as Box<T>;
      value = chatsBox.get(path);
      await box.close();
    });

    return value;
  }

  @override
  void write<T>(String path, T data) {
    Hive.openBox("chats").then((box) async {
      await box.put(path, data);
      await box.close();
    });
  }

  @override
  void delete(String path) async {
    Hive.openBox("chats").then((box) async {
      await box.delete(path);
      await box.close();
    });
  }

  @override
  Future<void> init() async {
    await Hive.openBox("chats");
  }

  @override
  Future<void> close() async {
    await Hive.close();
  }
}
