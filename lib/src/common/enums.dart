import 'package:flutter/foundation.dart';

enum Side {
  BUY,
  SELL,
}

extension SideExt on Side {
  String toStr() => describeEnum(this);
}

enum PositionSide {
  LONG,
  SHORT,
  BOTH,
}

extension PosSideExt on PositionSide {
  String toStr() => describeEnum(this);
}

enum OrderType {
  LIMIT,
  MARKET,
  STOP,
  STOP_MARKET,
  TAKE_PROFIT,
  TAKE_PROFIT_MARKET,
  TRAILING_STOP_MARKET,
  LIQUIDATION,
}

extension OrderTypeExt on OrderType {
  String toStr() => describeEnum(this);
}

enum Interval {
  INTERVAL_1m,
  INTERVAL_3m,
  INTERVAL_5m,
  INTERVAL_15m,
  INTERVAL_30m,
  INTERVAL_1h,
  INTERVAL_2h,
  INTERVAL_4h,
  INTERVAL_6h,
  INTERVAL_8h,
  INTERVAL_12h,
  INTERVAL_1d,
  INTERVAL_3d,
  INTERVAL_1w,
  INTERVAL_1M,
}

extension IntervalExt on Interval {
  String toStr() => describeEnum(this).split("_").last;
}

enum OrderStatus {
  NEW,
  PARTIALLY_FILLED,
  FILLED,
  CANCELED,
  REJECTED,
  EXPIRED,
  NEW_INSURANCE,
  NEW_ADL,
}

extension OrderStatusExt on OrderStatus {
  String toStr() => describeEnum(this);
}

enum ExecutionType {
  NEW,
  CANCELED,
  CALCULATED,
  EXPIRED,
  TRADE,
}

extension ExecutionTypeExt on ExecutionType {
  String toStr() => describeEnum(this);
}

enum TimeInForce {
  GTC,
  IOC,
  FOK,
  GTX,
}

extension TimeInForceExt on TimeInForce {
  String toStr() => describeEnum(this);
}

extension EnumExt on String {
  Side toSideEnum() => Side.values.firstWhere((s) => describeEnum(s) == this);
  PositionSide toPositionSideEnum() =>
      PositionSide.values.firstWhere((s) => describeEnum(s) == this);
  OrderType toOrderTypeEnum() =>
      OrderType.values.firstWhere((s) => describeEnum(s) == this);
  ExecutionType toExecutionTypeEnum() =>
      ExecutionType.values.firstWhere((s) => describeEnum(s) == this);
  OrderStatus toOrderStatusEnum() =>
      OrderStatus.values.firstWhere((s) => describeEnum(s) == this);
  Interval toIntervalEnum() => Interval.values
      .firstWhere((s) => describeEnum(s).split("_").last == this);
  TimeInForce toTimeInForceEnum() =>
      TimeInForce.values.firstWhere((s) => describeEnum(s) == this);
}
