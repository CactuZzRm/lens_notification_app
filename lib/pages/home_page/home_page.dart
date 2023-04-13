import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lens_notification_app/pages/home_page/components/change_date_button.dart';
import 'package:lens_notification_app/pages/home_page/components/selectable_date_view_widget.dart';
import 'package:lens_notification_app/providers/theme_state_provider.dart';
import 'package:lens_notification_app/providers/timer_state_provider.dart';

import '../../providers/shared_preferences_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

const String endDateSharedKey = 'endDateKey';
const String darkThemeSharedKey = 'darkThemeKey';
const String fullDateSharedKey = 'fullDateKey';

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final endDate = ref.watch(endDateProvider) != '' ? DateTime.parse(ref.watch(endDateProvider)) : null;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => ref.read(themeStateProvider.notifier).newState(),
              icon: Icon(
                !ref.watch(themeStateProvider) ? Icons.nightlight : Icons.sunny,
                color: ref.watch(themeStateProvider)
                    ? const Color.fromRGBO(255, 217, 0, 1)
                    : const Color.fromRGBO(89, 89, 255, 1),
              ),
            ),
            IconButton(
              onPressed: () async => (await ref.read(getSharedPreferencesProvider.future)).remove(endDateSharedKey),
              icon: Icon(Icons.cleaning_services, color: ref.watch(themeStateProvider) ? Colors.white : Colors.black),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedCrossFade(
                firstChild: const NoDataTextWidget(),
                secondChild: const SelectableDateViewWidget(),
                crossFadeState: endDate == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 150),
              ),
              const ChangeDateButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class NoDataTextWidget extends StatelessWidget {
  const NoDataTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: MediaQuery.of(context).size.width * 0.6,
      alignment: Alignment.center,
      child: const Text(
        'Дата не установлена',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
