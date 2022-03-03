import 'package:binance_futures/src/binance_futures_api.dart';
import 'package:binance_futures/src/websocket/classes.dart';

extension UserDataWebsockets on BinanceFutures {
  /// Subscribe to userdata stream
  ///
  /// data pushed can be WsListenKeyExpiredEvent / WsMarginCallEvent / WsAccountUpdateEvent / WsOrderUpdateEvent
  /// / WsLeverageUpdateEvent / WsAccountConfigUpdateEvent or Map if unknown
  Stream<dynamic> userDataStream({
    required String listenKey,
  }) {
    final channel = subscribe(listenKey);
    return channel.stream.map<Map>(toMap).map<dynamic>((e) {
      if (e["e"] == "listenKeyExpired") {
        return WsListenKeyExpiredEvent.fromMap(e);
      } else if (e["e"] == "MARGIN_CALL") {
        return WsMarginCallEvent.fromMap(e);
      } else if (e["e"] == "ACCOUNT_UPDATE") {
        return WsAccountUpdateEvent.fromMap(e);
      } else if (e["e"] == "ORDER_TRADE_UPDATE") {
        return WsOrderUpdateEvent.fromMap(e);
      } else if (e["e"] == "ACCOUNT_CONFIG_UPDATE") {
        if (e.containsKey("ac")) {
          return WsLeverageUpdateEvent.fromMap(e);
        } else if (e.containsKey("ai")) {
          return WsAccountConfigUpdateEvent.fromMap(e);
        } else {
          return e;
        }
      } else {
        return e;
      }
    });
  }
}
