import 'package:equatable/equatable.dart';
import '../models/sleep_record.dart';

abstract class SleepState extends Equatable {
  const SleepState();
  @override
  List<Object?> get props => [];
}

// Начальное состояние (ничего не загружено)
class SleepInitial extends SleepState {}

// Состояние загрузки (показываем крутилку)
class SleepLoading extends SleepState {}

// Состояние успешной загрузки: список записей
class SleepLoaded extends SleepState {
  final List<SleepRecord> records;
  const SleepLoaded(this.records);
  @override
  List<Object?> get props => [records];
}

// Состояние ошибки
class SleepError extends SleepState {
  final String message;
  const SleepError(this.message);
  @override
  List<Object?> get props => [message];
}