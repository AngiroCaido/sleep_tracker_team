import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/sleep_bloc.dart';
import '../blocs/sleep_event.dart';
import '../models/sleep_record.dart';

class AddRecordScreen extends StatefulWidget {
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  DateTime bedtime = DateTime.now();
  DateTime wakeup = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Новая запись')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text('Время начала сна'),
              subtitle: Text('${bedtime.hour}:${bedtime.minute} ${bedtime.day}.${bedtime.month}'),
              trailing: Icon(Icons.edit),
              onTap: () async {
                final picked = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(bedtime));
                if (picked != null) {
                  setState(() {
                    bedtime = DateTime(bedtime.year, bedtime.month, bedtime.day, picked.hour, picked.minute);
                  });
                }
              },
            ),
            ListTile(
              title: Text('Время пробуждения'),
              subtitle: Text('${wakeup.hour}:${wakeup.minute} ${wakeup.day}.${wakeup.month}'),
              trailing: Icon(Icons.edit),
              onTap: () async {
                final picked = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(wakeup));
                if (picked != null) {
                  setState(() {
                    wakeup = DateTime(wakeup.year, wakeup.month, wakeup.day, picked.hour, picked.minute);
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Сохранить'),
              onPressed: () {
                final record = SleepRecord(bedtime: bedtime, wakeup: wakeup);
                context.read<SleepBloc>().add(AddRecord(record));
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}