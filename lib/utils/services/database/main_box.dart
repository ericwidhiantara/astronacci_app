// ignore_for_file: unnecessary_import

import 'dart:convert';
import 'dart:developer' as developer;

import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// ObjectBox entity for storing key-value pairs
@Entity()
class MainBoxData {
  @Id()
  int id = 0;

  String key;
  String value; // Store JSON-serialized data or direct String for tokens

  MainBoxData(this.key, this.value);
}

enum ActiveTheme {
  light(ThemeMode.light),
  dark(ThemeMode.dark),
  system(ThemeMode.system);

  final ThemeMode mode;

  const ActiveTheme(this.mode);
}

enum MainBoxKeys {
  token,
  fcm,
  language,
  theme,
  locale,
  isLogin,
  tokenData,
}

class ObjectBoxMain {
  /// The Store of this app.
  late final Store _store;

  /// A Box for main box data.
  late final Box<MainBoxData> _mainBox;

  ObjectBoxMain._create(this._store) {
    _mainBox = Box<MainBoxData>(_store);
  }

  /// Create an instance of ObjectBoxMain to use throughout the app.
  static Future<ObjectBoxMain> create(String prefixBox) async {
    final dir = await getApplicationDocumentsDirectory();
    final storePath = p.join(dir.path, "$prefixBox-mpp");
    final store = await openStore(directory: storePath);
    return ObjectBoxMain._create(store);
  }

  Future<void> addData<T>(MainBoxKeys key, T value) async {
    try {
      // Store Strings directly, serialize other types to JSON
      final serializedValue = value is String ? value : jsonEncode(value);
      developer.log(
          "Storing data for key: ${key.name}, value: $serializedValue",
          name: 'ObjectBoxMain');
      final data = MainBoxData(key.name, serializedValue);
      await _mainBox.putAsync(data);
      developer.log("Successfully stored data for key: ${key.name}",
          name: 'ObjectBoxMain');
    } catch (e, stackTrace) {
      developer.log("Error storing data for key: ${key.name}: $e",
          name: 'ObjectBoxMain', error: e, stackTrace: stackTrace);
      FirebaseCrashLogger().nonFatalError(error: e, stackTrace: stackTrace);
    }
  }

  Future<void> removeData(MainBoxKeys key) async {
    try {
      final query = _mainBox.query(MainBoxData_.key.equals(key.name)).build();
      final ids = query.findIds();
      if (ids.isNotEmpty) {
        await _mainBox.removeManyAsync(ids);
        developer.log("Successfully removed data for key: ${key.name}",
            name: 'ObjectBoxMain');
      } else {
        developer.log("No data found to remove for key: ${key.name}",
            name: 'ObjectBoxMain');
      }
      query.close();
    } catch (e, stackTrace) {
      developer.log("Error removing data for key: ${key.name}: $e",
          name: 'ObjectBoxMain', error: e, stackTrace: stackTrace);
      FirebaseCrashLogger().nonFatalError(error: e, stackTrace: stackTrace);
    }
  }

  T? getData<T>(MainBoxKeys key) {
    try {
      final query = _mainBox.query(MainBoxData_.key.equals(key.name)).build();
      final result = query.findFirst();
      query.close();
      if (result == null) {
        developer.log("No data found for key: ${key.name}",
            name: 'ObjectBoxMain');
        return null;
      }
      developer.log(
          "Retrieved raw data for key: ${key.name}, value: ${result.value}, type: $T",
          name: 'ObjectBoxMain');
      // Handle String types directly
      if (T == String || result is String) {
        developer.log(
            "Returning String value for key: ${key.name}: ${result.value}",
            name: 'ObjectBoxMain');
        return result.value as T?;
      }
      // Handle other types with JSON deserialization
      try {
        final deserializedValue = jsonDecode(result.value);
        developer.log(
            "Deserialized data for key: ${key.name}, value: $deserializedValue",
            name: 'ObjectBoxMain');
        return deserializedValue as T?;
      } on FormatException catch (e) {
        developer.log(
            "FormatException during JSON decode for key: ${key.name}: $e",
            name: 'ObjectBoxMain',
            error: e);
        // If JSON decode fails, return null
        return null;
      }
    } catch (e, stackTrace) {
      developer.log("Error retrieving data for key: ${key.name}: $e",
          name: 'ObjectBoxMain', error: e, stackTrace: stackTrace);
      FirebaseCrashLogger().nonFatalError(error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Future<void> debugBoxContents() async {
    try {
      final query = _mainBox.query().build();
      final results = query.find();
      query.close();
      if (results.isEmpty) {
        developer.log("ObjectBox is empty", name: 'ObjectBoxMain');
      } else {
        for (final data in results) {
          developer.log("Key: ${data.key}, Value: ${data.value}",
              name: 'ObjectBoxMain');
        }
      }
    } catch (e, stackTrace) {
      developer.log("Error reading box contents: $e",
          name: 'ObjectBoxMain', error: e, stackTrace: stackTrace);
      FirebaseCrashLogger().nonFatalError(error: e, stackTrace: stackTrace);
    }
  }

  Future<void> logoutBox() async {
    try {
      await removeData(MainBoxKeys.isLogin);
      await removeData(MainBoxKeys.token);
      developer.log("Successfully cleared login data", name: 'ObjectBoxMain');
    } catch (e, stackTrace) {
      developer.log("Error clearing login data: $e",
          name: 'ObjectBoxMain', error: e, stackTrace: stackTrace);
      FirebaseCrashLogger().nonFatalError(error: e, stackTrace: stackTrace);
    }
  }

  Future<void> closeBox({bool isUnitTest = false}) async {
    try {
      _store.close();
      developer.log("ObjectBox store closed", name: 'ObjectBoxMain');
    } catch (e, stackTrace) {
      if (!isUnitTest) {
        developer.log("Error closing ObjectBox store: $e",
            name: 'ObjectBoxMain', error: e, stackTrace: stackTrace);
        FirebaseCrashLogger().nonFatalError(error: e, stackTrace: stackTrace);
      }
    }
  }
}

// Mixin class for compatibility with existing code
mixin class MainBoxMixin {
  static ObjectBoxMain? _objectBox;

  static Future<void> initObjectBox(String prefixBox) async {
    _objectBox = await ObjectBoxMain.create(prefixBox);
    developer.log("ObjectBox initialized with prefix: $prefixBox",
        name: 'MainBoxMixin');
  }

  Future<void> addData<T>(MainBoxKeys key, T value) async {
    await _objectBox?.addData(key, value);
  }

  Future<void> removeData(MainBoxKeys key) async {
    await _objectBox?.removeData(key);
  }

  T? getData<T>(MainBoxKeys key) {
    return _objectBox?.getData<T>(key);
  }

  Future<void> debugBoxContents() async {
    await _objectBox?.debugBoxContents();
  }

  Future<void> logoutBox() async {
    await _objectBox?.logoutBox();
  }

  Future<void> closeBox({bool isUnitTest = false}) async {
    await _objectBox?.closeBox(isUnitTest: isUnitTest);
    _objectBox = null;
  }
}
