import 'package:lens_notification_app/pages/home_page/home_page.dart';
import 'package:lens_notification_app/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'timer_state_provider.g.dart';

@Riverpod(keepAlive: true)
class EndDate extends _$EndDate {
  late final Future<SharedPreferences> _sharedPreferences;

  @override
  String build() {
    _sharedPreferences = ref.read(getSharedPreferencesProvider.future);
    return '';
  }

  Future<void> init() async {
    final shared = await _sharedPreferences;
    if (!shared.containsKey(endDateSharedKey)) {
      return;
    }
    state = shared.getString(endDateSharedKey) ?? '';
  }

  void newState(String value) {
    state = value;
    _saveState();
  }

  Future<void> _saveState() async {
    (await _sharedPreferences).setString(endDateSharedKey, state);
  }
}

@Riverpod(keepAlive: true)
class FullDate extends _$FullDate {
  late final Future<SharedPreferences> _sharedPreferences;

  @override
  bool build() {
    _sharedPreferences = ref.read(getSharedPreferencesProvider.future);
    return false;
  }

  Future<void> init() async {
    final shared = await _sharedPreferences;
    if (!shared.containsKey(fullDateSharedKey)) {
      return;
    }
    state = shared.getBool(fullDateSharedKey) ?? false;
  }

  void newState() {
    state = !state;
    _saveState();
  }

  Future<void> _saveState() async {
    (await _sharedPreferences).setBool(endDateSharedKey, state);
  }
}
