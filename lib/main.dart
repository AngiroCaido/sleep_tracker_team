import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'repositories/sleep_repository.dart';
import 'blocs/sleep_bloc.dart';
import 'blocs/sleep_event.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final repository = SleepRepository();           // ← теперь конструктор существует
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final SleepRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SleepBloc(repository)..add(LoadRecords()),
      child: MaterialApp(
        title: 'Трекер сна',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: HomeScreen(),
      ),
    );
  }
}