import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'sleep_record.g.dart';

@HiveType(typeId: 0)
class SleepRecord extends Equatable {
  @HiveField(0)
  final DateTime bedtime;
  
  @HiveField(1)
  final DateTime wakeup;

  SleepRecord({required this.bedtime, required this.wakeup});

  Duration get duration => wakeup.difference(bedtime);

  @override
  List<Object?> get props => [bedtime, wakeup];
}