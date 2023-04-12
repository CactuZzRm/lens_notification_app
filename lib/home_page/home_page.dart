import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lens_notification_app/providers/theme_state_provider.dart';
import 'package:lens_notification_app/providers/timer_state_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isFullDate = true;

  void setNewEndDate(WidgetRef ref, Duration leftTime) {
    ref.read(timerStateProvider.notifier).update((state) => DateTime.now().add(leftTime));
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
              endDate != null
                  ? InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () => setState(() {
                        isFullDate = !isFullDate;
                      }),
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
                              DateFormat('dd-MM-yyyy').format(endDate),
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
                              endDate.difference(DateTime.now()).inDays.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        crossFadeState: isFullDate ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 220),
                        // child: SizedBox(
                        //   width: deviceSize.width * 0.6,
                        //   child: ListView(
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     children: [
                        //       const Text(
                        //         'Следующая замена линз:',
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(
                        //           fontSize: 18,
                        //         ),
                        //       ),
                        //       const SizedBox(height: 8),
                        //       Text(
                        //         isFullDate
                        //             ? DateFormat('dd-MM-yyyy').format(endDate)
                        //             : endDate.difference(DateTime.now()).inDays.toString(),
                        //         textAlign: TextAlign.center,
                        //         style: const TextStyle(
                        //           fontSize: 22,
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ),
                    )
                  : const Text(
                      'Дата не установлена',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
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
                    setNewEndDate(ref, Duration(days: 2));
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
                  child: const Text(
                    'Установить таймер',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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