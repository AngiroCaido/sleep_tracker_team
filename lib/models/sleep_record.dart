import 'package:equatable/equatable.dart';

class SleepRecord extends Equatable {
  final DateTime bedtime;
  final DateTime wakeup;

  const SleepRecord({required this.bedtime, required this.wakeup});

  Duration get duration => wakeup.difference(bedtime);

  @override
  List<Object?> get props => [bedtime, wakeup];
}