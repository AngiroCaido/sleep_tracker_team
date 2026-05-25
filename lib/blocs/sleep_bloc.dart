import 'package:flutter_bloc/flutter_bloc.dart';
import 'sleep_event.dart';
import 'sleep_state.dart';
import '../repositories/sleep_repository.dart';

class SleepBloc extends Bloc<SleepEvent, SleepState> {
  final SleepRepository repository;

  SleepBloc(this.repository) : super(SleepInitial()) {
    on<LoadRecords>(_onLoadRecords);
    on<AddRecord>(_onAddRecord);
    on<DeleteRecord>(_onDeleteRecord);
  }

  Future<void> _onLoadRecords(LoadRecords event, Emitter<SleepState> emit) async {
    emit(SleepLoading());
    try {
      final records = await repository.getAllRecords();
      emit(SleepLoaded(records));
    } catch (e) {
      emit(SleepError(e.toString()));
    }
  }

  Future<void> _onAddRecord(AddRecord event, Emitter<SleepState> emit) async {
    try {
      await repository.addRecord(event.record);
      // После успешного добавления перезагружаем список
      add(LoadRecords());
    } catch (e) {
      emit(SleepError(e.toString()));
    }
  }

  Future<void> _onDeleteRecord(DeleteRecord event, Emitter<SleepState> emit) async {
    try {
      await repository.deleteRecord(event.index);
      add(LoadRecords());
    } catch (e) {
      emit(SleepError(e.toString()));
    }
  }
}