import 'package:equatable/equatable.dart';
import '../models/sleep_record.dart';   // используем временную модель

abstract class SleepEvent extends Equatable {
  const SleepEvent();
  @override
  List<Object?> get props => [];
}

// Событие: загрузить все записи из репозитория
class LoadRecords extends SleepEvent {}

// Событие: добавить новую запись
class AddRecord extends SleepEvent {
  final SleepRecord record;
  const AddRecord(this.record);
  @override
  List<Object?> get props => [record];
}

// Событие: удалить запись по индексу
class DeleteRecord extends SleepEvent {
  final int index;
  const DeleteRecord(this.index);
  @override
  List<Object?> get props => [index];
}