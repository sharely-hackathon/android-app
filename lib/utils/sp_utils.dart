import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lang/translations.dart';

/// 封装 SharedPreferences。
class SPUtils {
  // 单例生命。
  factory SPUtils() => _instance;

  SPUtils._internal();

  static final SPUtils _instance = SPUtils._internal();

  // 保持一个sp的引用
  static late final SharedPreferences _sp;

  /// 初始化方法，只调用一次
  static Future<SPUtils> init() async {
    _sp = await SharedPreferences.getInstance();
    return _instance;
  }

  /// 写入数据
  static void set<T>(String key, T value) {
    Type type = value.runtimeType;
    switch (type) {
      case String:
        _sp.setString(key, value as String);
        break;
      case int:
        _sp.setInt(key, value as int);
        break;
      case bool:
        _sp.setBool(key, value as bool);
        break;
      case double:
        _sp.setDouble(key, value as double);
        break;
      case const (List<String>):
        _sp.setStringList(key, value as List<String>);
        break;
    }

    /// map不能直接判断Type类型，他是一个_InternalLinkedHashMap是一个私有类型，没有办法引用出来。
    if (value is Map) {
      // map，转成json格式的字符串进行保存。序列化成json字符串
      _sp.setString(key, json.encode(value));
      return;
    }
  }

  /// 根据key。读取数据，
  static Object? get<T>(String key) {
    var value = _sp.get(key);
    if (value is String) {
      try {
        // 尝试反序列化JSON
        final decoded = const JsonDecoder().convert(value);
        // 只有当解析出来的是Map时才转换为Map<String, dynamic>
        if (decoded is Map) {
          return decoded as Map<String, dynamic>;
        }
        // 如果不是Map，说明原本就是普通字符串值，返回原字符串
        return value;
      } on FormatException {
        return value; // 返回字符串
      }
    }
    return value;
  }

  /// -------------其他方法封装-----------------
  /// 获取所有的key
  static Set<String> getKeys() {
    return _sp.getKeys();
  }

  /// 判断数据中是否包含某个key
  static bool containsKey(String key) {
    return _sp.containsKey(key);
  }

  /// 删除数据中某个key
  static Future<bool> remove(String key) async {
    return await _sp.remove(key);
  }

  /// 清空所有数据
  static Future<bool> clear() async {
    return await _sp.clear();
  }

  /// 重新加载
  static Future<void> reload() async {
    return await _sp.reload();
  }

  /// 保存JSON List数据（专门用于缓存）
  static void setJsonList(String key, List<Map<String, dynamic>> list) {
    final jsonString = json.encode(list);
    _sp.setString(key, jsonString);
  }

  /// 获取JSON List数据（专门用于缓存）
  static List<Map<String, dynamic>>? getJsonList(String key) {
    try {
      final jsonString = _sp.getString(key);
      if (jsonString == null || jsonString.isEmpty) {
        return null;
      }
      final List<dynamic> decoded = json.decode(jsonString);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return null;
    }
  }

  static void setLocal(var languageCode) {
    _sp.setString("language", languageCode);
  }

  static Locale? getLocal() {
    String? local = _sp.getString("language");
    if (local == null) return Get.deviceLocale; //没有设置，跟随系统
    if (local == ESES.languageCode) {
      // Get.updateLocale(CHINA);
      return ESES;
    } else {
      //Get.updateLocale(ENGLISH);
      return ENGLISH;
    }
  }
}
