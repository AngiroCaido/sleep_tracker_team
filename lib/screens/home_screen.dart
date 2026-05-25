import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/sleep_bloc.dart';
import '../blocs/sleep_event.dart';
import '../blocs/sleep_state.dart';
import 'add_record_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Трекер сна'),
        centerTitle: true,
      ),
      body: BlocBuilder<SleepBloc, SleepState>(
        builder: (context, state) {
          if (state is SleepLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SleepLoaded) {
            final records = state.records;
            if (records.isEmpty) {
              return const Center(
                child: Text('Нет записей. Добавьте сон!'),
              );
            }
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return Dismissible(
                  key: Key(record.bedtime.toIso8601String()),
                  background: Container(color: Colors.red),
                  onDismissed: (_) {
                    context.read<SleepBloc>().add(DeleteRecord(index));
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ListTile(
                      title: Text(
                        'Сон: ${record.duration.inHours} ч '
                        '${record.duration.inMinutes.remainder(60)} мин',
                      ),
                      subtitle: Text(
                        'Лёг: ${_formatTime(record.bedtime)} — '
                        'Встал: ${_formatTime(record.wakeup)}',
                      ),
                    ),
                  ),
                );
              },
            );
          }

          if (state is SleepError) {
            return Center(
              child: Text('Ошибка: ${state.message}'),
            );
          }

          return const Center(
            child: Text('Нажмите + для добавления'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddRecordScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Статистика',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StatsScreen()),
            );
          }
        },
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}