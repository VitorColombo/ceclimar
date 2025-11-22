import 'package:hive/hive.dart';
import 'package:tcc_ceclimar/utils/register_status.dart';

part 'local_register.g.dart';

@HiveType(typeId: 0)
class LocalRegister {
  @HiveField(0)
  final String registerType;
  @HiveField(1)
  final Map<String, dynamic> data;
  @HiveField(2)
  final RegisterStatus status;
  @HiveField(3)
  final String? registerImagePath;
  @HiveField(4)
  final String? registerImagePath2;
  @HiveField(5)
  final DateTime createdAt;

  LocalRegister({
    required this.registerType,
    required this.data,
    required this.status,
    this.registerImagePath,
    this.registerImagePath2,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'registerType': registerType,
      'data': data,
      'status': status.toString(),
      'registerImagePath': registerImagePath,
      'registerImagePath2': registerImagePath2,
      };
  }
}