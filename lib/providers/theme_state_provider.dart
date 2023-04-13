import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lens_notification_app/home_page/home_page.dart';
import 'package:lens_notification_app/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state_provider.g.dart';

//final themeStateProvider = StateProvider<bool>((ref) => false);

// @riverpod
// ThemeState themeState(ThemeStateRef ref) {
//   bool isDarkTheme = false;

//   void cahngeTheme() {
//     isDarkTheme = !isDarkTheme;
//   }

//   return isDarkTheme;
// }

@Riverpod(keepAlive: true)
class ThemeState extends _$ThemeState {
  late final Future<SharedPreferences> _sharedPreferences;

  @override
  bool build() {
    _sharedPreferences = ref.read(getSharedPreferencesProvider.future);
    return false;
  }

  Future<void> init() async {
    final shared = await _sharedPreferences;
    if(!shared.containsKey(darkThemeSharedKey)) {
      return;
    }
    state = shared.getBool(darkThemeSharedKey) ?? false;
  }

  void newState() {
    state = !state;
    _saveState();
  }

  Future<void> _saveState() async {
    (await _sharedPreferences).setBool(darkThemeSharedKey, state);
  }
}