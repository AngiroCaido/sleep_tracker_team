import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/sleep_bloc.dart';
import '../blocs/sleep_state.dart';
import '../widgets/sleep_chart.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Статистика сна')),
      body: BlocBuilder<SleepBloc, SleepState>(
        builder: (context, state) {
          if (state is SleepLoaded) {
            final records = state.records;
            if (records.isEmpty) return Center(child: Text('Нет данных'));
            final totalHours = records.map((r) => r.duration.inHours).reduce((a,b)=>a+b);
            final avgHours = totalHours / records.length;
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text('Средняя длительность сна: ${avgHours.toStringAsFixed(1)} ч', style: TextStyle(fontSize: 18)),
                          Text('Всего записей: ${records.length}'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Ежедневная длительность (последние 7 дней)'),
                  Expanded(child: SleepChart(records: records)),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}