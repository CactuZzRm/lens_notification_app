import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lens_notification_app/providers/shared_preferences_provider.dart';
import 'package:lens_notification_app/providers/theme_state_provider.dart';
import 'package:lens_notification_app/providers/timer_state_provider.dart';
import 'package:lens_notification_app/themes/themes.dart';

import 'home_page/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ThemesCatalog();
    return FutureBuilder(
      future: Future.wait([
        ref.watch(themeStateProvider.notifier).init(),
        ref.watch(timerStateProvider.notifier).init(),
      ]),
      builder: ((context, snapshot) {
        return MaterialApp(
          theme: ref.watch(themeStateProvider) ? appTheme.darkTheme : appTheme.lightTheme,
          title: 'Lens notifier app',
          home: const HomePage(),
        );
      }),
    );
  }
}
