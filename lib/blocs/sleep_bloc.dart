import 'package:flutter_bloc/flutter_bloc.dart';
import 'sleep_event.dart';
import 'sleep_state.dart';
import '../repositories/sleep_repository.dart';

class SleepBloc extends Bloc<SleepEvent, SleepState> {
  final SleepRepository repository;

  SleepBloc(this.repository) : super(SleepInitial()) {
    // Регистрируем обработчики событий
    on<LoadRecords>(_onLoadRecords);
    on<AddRecord>(_onAddRecord);
    on<DeleteRecord>(_onDeleteRecord);
  }

  // Обработчик загрузки записей
  Future<void> _onLoadRecords(LoadRecords event, Emitter<SleepState> emit) async {
    emit(SleepLoading());
    try {
      final records = await repository.getAllRecords();
      emit(SleepLoaded(records));
    } catch (e) {
      emit(SleepError(e.toString()));
    }
  }

  // Обработчик добавления записи
  Future<void> _onAddRecord(AddRecord event, Emitter<SleepState> emit) async {
    await repository.addRecord(event.record);
    // После добавления перезагружаем список
    add(LoadRecords());
  }

  // Обработчик удаления записи
  Future<void> _onDeleteRecord(DeleteRecord event, Emitter<SleepState> emit) async {
    await repository.deleteRecord(event.index);
    add(LoadRecords());
  }
}