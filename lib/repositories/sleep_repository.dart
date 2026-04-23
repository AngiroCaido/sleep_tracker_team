import 'package:hive_flutter/hive_flutter.dart';
import '../models/sleep_record.dart';  // эта модель пока не создана, но мы её создадим позже

class SleepRepository {
  // Имя коробки (box) в Hive, где будут храниться записи
  static const String _boxName = 'sleep_records';
  
  // Ссылка на коробку (будет инициализирована позже)
  late final Box<SleepRecord> _box;

  // Конструктор. При создании объекта репозитория вызываем инициализацию
  SleepRepository() {
    _init();
  }

  // Асинхронная инициализация: открываем Hive и коробку
  Future<void> _init() async {
    await Hive.initFlutter();                      // инициализируем Hive
    Hive.registerAdapter(SleepRecordAdapter());    // регистрируем адаптер для нашей модели (будет создан позже)
    _box = await Hive.openBox<SleepRecord>(_boxName); // открываем коробку
  }

  // Получить все записи из коробки (список SleepRecord)
  Future<List<SleepRecord>> getAllRecords() async {
    return _box.values.toList();
  }

  // Добавить новую запись
  Future<void> addRecord(SleepRecord record) async {
    await _box.add(record);
  }

  // Удалить запись по индексу (позиции в списке)
  Future<void> deleteRecord(int index) async {
    await _box.deleteAt(index);
  }
}