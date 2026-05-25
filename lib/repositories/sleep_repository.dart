import 'package:hive_flutter/hive_flutter.dart';
import '../models/sleep_record.dart';

class SleepRepository {
  static const String _boxName = 'sleep_records';
  static bool _adapterRegistered = false;

  Future<Box<SleepRecord>> _getBox() async {
    await Hive.initFlutter();
    
    // Регистрируем адаптер только один раз
    if (!_adapterRegistered) {
      Hive.registerAdapter(SleepRecordAdapter());
      _adapterRegistered = true;
      print('✅ Адаптер SleepRecord зарегистрирован');
    }
    
    return await Hive.openBox<SleepRecord>(_boxName);
  }

  Future<List<SleepRecord>> getAllRecords() async {
    final box = await _getBox();
    return box.values.toList();
  }

  Future<void> addRecord(SleepRecord record) async {
    final box = await _getBox();
    await box.add(record);
    print('✅ Добавлена запись, всего: ${box.length}');
  }

  Future<void> deleteRecord(int index) async {
    final box = await _getBox();
    await box.deleteAt(index);
  }
}