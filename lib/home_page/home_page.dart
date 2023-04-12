import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lens_notification_app/providers/theme_state_provider.dart';
import 'package:lens_notification_app/providers/timer_state_provider.dart';
import 'package:lens_notification_app/themes/themes.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isFullDate = true;

  void setNewEndDate(WidgetRef ref, DateTime newDate) {
    // ref.read(timerStateProvider.notifier).update((state) => DateTime.now().add(leftTime));
    ref.read(timerStateProvider.notifier).update((state) => newDate);
  }

  @override
  Widget build(BuildContext context) {
    final endDate = ref.watch(timerStateProvider);
    final Size deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                ref.read(themeStateProvider.notifier).update((state) => !state);
              },
              icon: Icon(
                !ref.watch(themeStateProvider) ? Icons.nightlight : Icons.sunny,
                color: ref.watch(themeStateProvider)
                    ? const Color.fromRGBO(255, 217, 0, 1)
                    : const Color.fromRGBO(89, 89, 255, 1),
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedCrossFade(
                firstChild: const Text(
                  'Дата не установлена',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                secondChild: InkWell(
                  onTap: () => setState(() {
                    isFullDate = !isFullDate;
                  }),
                  onLongPress: () {
                    // Какое-нибудь пояснение
                    // Наверное flush-bar
                  },
                  splashColor: const Color.fromRGBO(55, 36, 150, 0.3), // расплывающийся при нажатии на фоне цвет
                  highlightColor: const Color.fromRGBO(255, 255, 255, 0.1), // Цвет блика
                  child: AnimatedCrossFade(
                    firstChild: Column(
                      children: [
                        const Text(
                          'Следующая замена линз:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('dd.MM.yyyy').format(endDate ?? DateTime.now()),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    secondChild: Column(
                      children: [
                        const Text(
                          'Следующая замена линз:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          endDate != null
                              ? endDate.difference(DateTime.now()).inDays.toString()
                              : 'Что-то пошло не так',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    crossFadeState: isFullDate ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 220),
                  ),
                ),
                crossFadeState: endDate == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 150),
              ),
              Container(
                width: deviceSize.width * 0.35,
                height: deviceSize.height * 0.35,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(71, 56, 242, 1),
                      Color.fromRGBO(123, 68, 243, 1),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => Container(
                        height: deviceSize.height * 0.25,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color.fromRGBO(71, 56, 242, 1), Color.fromRGBO(123, 68, 243, 1)],
                          ),
                        ),
                        child: CupertinoTheme(
                          data: CupertinoThemeData(
                            brightness: Brightness.dark,
                            textTheme: CupertinoTextThemeData(
                              dateTimePickerTextStyle: TextStyle(
                                color: ThemesCatalog().darkTheme.textTheme.bodyLarge!.color,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: endDate ?? DateTime.now(),
                            onDateTimeChanged: (DateTime newDateTime) {
                              setNewEndDate(ref, newDateTime);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    // 71, 56, 242 Левая сторона градиента
                    // 123, 68, 243 Правая сторона
                    backgroundColor: Colors.transparent,
                    shape: const CircleBorder(),
                    fixedSize: Size(
                      deviceSize.width * 0.35,
                      deviceSize.height * 0.35,
                    ),
                  ),
                  child: Text(
                    endDate == null ? 'Установить таймер' : 'Изменить дату',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
