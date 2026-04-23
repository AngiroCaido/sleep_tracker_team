import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/sleep_bloc.dart';
import '../blocs/sleep_event.dart';
import '../blocs/sleep_state.dart';
import 'add_record_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Трекер сна'), centerTitle: true),
      body: BlocBuilder<SleepBloc, SleepState>(
        builder: (context, state) {
          if (state is SleepLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SleepLoaded) {
            final records = state.records;
            if (records.isEmpty) {
              return Center(child: Text('Нет записей. Добавьте сон!'));
            }
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (ctx, idx) {
                final r = records[idx];
                return Dismissible(
                  key: Key(r.bedtime.toString()),
                  background: Container(color: Colors.red),
                  onDismissed: (_) {
                    context.read<SleepBloc>().add(DeleteRecord(idx));
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: ListTile(
                      title: Text('Сон: ${r.duration.inHours} ч ${r.duration.inMinutes.remainder(60)} мин'),
                      subtitle: Text('Легли: ${_formatTime(r.bedtime)} — Встали: ${_formatTime(r.wakeup)}'),
                    ),
                  ),
                );
              },
            );
          } else if (state is SleepError) {
            return Center(child: Text('Ошибка: ${state.message}'));
          }
          return Center(child: Text('Нажмите + для добавления'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddRecordScreen()));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Статистика'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => StatsScreen()));
          }
        },
      ),
    );
  }

  String _formatTime(DateTime dt) => '${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(2,'0')}';
}