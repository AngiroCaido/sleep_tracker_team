import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/sleep_record.dart';
import '../blocs/sleep_bloc.dart';
import '../blocs/sleep_event.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({super.key});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  DateTime bedtime = DateTime.now();
  DateTime wakeup = DateTime.now();

  // Функция для принудительного 24-часового TimePicker
  Future<TimeOfDay?> _show24hTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новая запись')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Время отхода ко сну
            ListTile(
              title: const Text('Время отхода ко сну'),
              subtitle: Text(
                  '${bedtime.hour.toString().padLeft(2, '0')}:${bedtime.minute.toString().padLeft(2, '0')} '
                  '${bedtime.day}.${bedtime.month}.${bedtime.year}'),
              trailing: const Icon(Icons.edit),
              onTap: () async {
                final TimeOfDay? picked = await _show24hTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(bedtime),
                );
                if (picked != null) {
                  setState(() {
                    bedtime = DateTime(
                      bedtime.year,
                      bedtime.month,
                      bedtime.day,
                      picked.hour,
                      picked.minute,
                    );
                  });
                }
              },
            ),
            // Время пробуждения
            ListTile(
              title: const Text('Время пробуждения'),
              subtitle: Text(
                  '${wakeup.hour.toString().padLeft(2, '0')}:${wakeup.minute.toString().padLeft(2, '0')} '
                  '${wakeup.day}.${wakeup.month}.${wakeup.year}'),
              trailing: const Icon(Icons.edit),
              onTap: () async {
                final TimeOfDay? picked = await _show24hTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(wakeup),
                );
                if (picked != null) {
                  setState(() {
                    wakeup = DateTime(
                      wakeup.year,
                      wakeup.month,
                      wakeup.day,
                      picked.hour,
                      picked.minute,
                    );
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final bloc = context.read<SleepBloc>();
                final record = SleepRecord(bedtime: bedtime, wakeup: wakeup);
                bloc.add(AddRecord(record));
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}