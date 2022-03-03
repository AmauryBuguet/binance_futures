import 'package:flutter/foundation.dart';

enum ContractType {
  perpetual,
  current_quarter,
  next_quarter,
}

extension ContractTypeExt on ContractType {
  String toStr() => describeEnum(this);
}

extension WsEnumExt on String {
  ContractType toContractTypeEnum() =>
      ContractType.values.firstWhere((s) => describeEnum(s) == this);
}
