import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final GetStorage _box = GetStorage();
  final _key = 'isDarkMode';

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  RxBool isDark = false.obs;

  bool _loadThemeFromBox() {
    return _box.read(_key) ?? false;
  }

  _saveThemeToBox(bool isDarkMode) {
    _box.write(_key, isDarkMode);
  }

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    isDark(!isDark.value);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
