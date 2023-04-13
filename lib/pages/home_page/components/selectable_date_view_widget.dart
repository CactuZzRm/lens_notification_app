import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../providers/timer_state_provider.dart';

class SelectableDateViewWidget extends ConsumerStatefulWidget {
  const SelectableDateViewWidget({super.key});

  @override
  ConsumerState<SelectableDateViewWidget> createState() => _SelectableDateViewWidgetState();
}

class _SelectableDateViewWidgetState extends ConsumerState<SelectableDateViewWidget> {
  @override
  Widget build(BuildContext context) {
    final endDate = ref.watch(endDateProvider) != '' ? DateTime.parse(ref.watch(endDateProvider)) : null;
    final isFullDate = ref.watch(fullDateProvider);
    return InkWell(
      onTap: () => setState(() {
        ref.watch(fullDateProvider.notifier).newState();
      }),
      onLongPress: () {
        // Какое-нибудь пояснение
        // Наверное flush-bar
      },
      splashColor: const Color.fromRGBO(55, 36, 150, 0.3), // расплывающийся при нажатии на фоне цвет
      highlightColor: const Color.fromRGBO(255, 255, 255, 0.1), // Цвет блика
      child: AnimatedCrossFade(
        firstChild: Container(
          height: 65,
          width: MediaQuery.of(context).size.width * 0.6,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const EndDateTitle(),
              const SizedBox(height: 4),
              Text(
                endDate != null ? DateFormat('dd.MM.yyyy').format(endDate) : 'Что-то пошло не так',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        secondChild: Container(
          height: 65,
          width: MediaQuery.of(context).size.width * 0.6,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const EndDateTitle(),
              const SizedBox(height: 4),
              Text(
                endDate != null ? (endDate.difference(DateTime.now()).inDays + 1).toString() : 'Что-то пошло не так',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        crossFadeState: isFullDate ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 220),
      ),
    );
  }
}

class EndDateTitle extends StatelessWidget {
  const EndDateTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Дата замены линз:',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }
}
