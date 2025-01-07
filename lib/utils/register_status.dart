 import 'package:hive/hive.dart';

  part 'register_status.g.dart';

  @HiveType(typeId: 1)
  enum RegisterStatus {
    @HiveField(0)
    pending,
    @HiveField(1)
    sent,
    @HiveField(2)
    error
  }