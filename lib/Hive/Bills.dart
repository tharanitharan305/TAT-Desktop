import 'dart:io';

import 'package:hive/hive.dart';
part 'Bills.g.dart';

@HiveType(typeId: 0)
class Bills {
  Bills({required this.bill});
  @HiveField(0)
  File bill;
}
