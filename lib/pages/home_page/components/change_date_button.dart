import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/timer_state_provider.dart';
import '../../../themes/themes.dart';

class ChangeDateButton extends ConsumerStatefulWidget {
  const ChangeDateButton({super.key});

  @override
  ConsumerState<ChangeDateButton> createState() => _ChangeDateButtonState();
}

class _ChangeDateButtonState extends ConsumerState<ChangeDateButton> {
  void setNewEndDate(WidgetRef ref, String newDate) {
    ref.read(endDateProvider.notifier).newState(newDate);
  }

  @override
  Widget build(BuildContext context) {
    final endDate = ref.watch(endDateProvider) != '' ? DateTime.parse(ref.watch(endDateProvider)) : null;
    final Size deviceSize = MediaQuery.of(context).size;

    return Container(
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
                    setNewEndDate(ref, newDateTime.toString());
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
          endDate == null ? 'Установить дату' : 'Изменить дату',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
