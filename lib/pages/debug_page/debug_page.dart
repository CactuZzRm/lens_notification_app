import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lens_notification_app/providers/shared_preferences_provider.dart';

class DP extends ConsumerWidget {
  const DP({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Очистить хранилище'),
            ElevatedButton(
              onPressed: () async => (await ref.read(getSharedPreferencesProvider.future)).clear(),
              child: Text('Очистить'),
            ),
          ],
        ),
      ),
    );
  }
}
