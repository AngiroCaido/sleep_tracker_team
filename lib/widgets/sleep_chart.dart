import 'package:flutter/material.dart';
import '../models/sleep_record.dart';

class SleepChart extends StatelessWidget {
  final List<SleepRecord> records;
  const SleepChart({required this.records});

  @override
  Widget build(BuildContext context) {
    final last7 = records.reversed.take(7).toList().reversed.toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: last7.map((r) {
        final hours = r.duration.inHours + r.duration.inMinutes / 60;
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: hours * 20,
              width: 30,
              color: Colors.blue,
            ),
            SizedBox(height: 4),
            Text('${r.duration.inHours}h'),
          ],
        );
      }).toList(),
    );
  }
}