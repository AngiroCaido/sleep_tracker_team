import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'repositories/sleep_repository.dart';
import 'blocs/sleep_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final repository = SleepRepository();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final SleepRepository repository;
  const MyApp(this.repository);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Трекер сна',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: BlocProvider(
        create: (_) => SleepBloc(repository)..add(LoadRecords()),
        child: Container(),        // Заглушка
      ),
    );
  }
}