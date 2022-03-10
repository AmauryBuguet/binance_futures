import 'package:binance_futures/src/binance_futures_api.dart';
import 'package:binance_futures/src/common/enums.dart';
import 'package:binance_futures/src/rest/classes.dart';
import 'package:binance_futures/src/rest/enums.dart';
import 'package:either_dart/either.dart';

extension AccountTradeEndpoints on BinanceFutures {
  /// Change user's position mode (Hedge Mode or One-way Mode ) on EVERY symbol
  ///
  /// "true": Hedge Mode; "false": One-way Mode
  Future<Either<String, bool>> changePositionMode({
    required bool dualSidePosition,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'dualSidePosition': dualSidePosition.toString(),
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/positionSide/dual',
      type: RequestType.POST,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : const Right(true));
  }

  /// Get user's position mode (Hedge Mode or One-way Mode ) on EVERY symbol
  Future<Either<String, bool>> getCurrentPositionMode({
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/positionSide/dual',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right['dualSidePosition']));
  }

  /// Change user's Multi-Assets mode (Multi-Assets Mode or Single-Asset Mode) on Every symbol
  ///
  /// "true": Multi-Assets Mode; "false": Single-Asset Mode
  Future<Either<String, bool>> changeMultiAssetMode({
    required bool multiAssetsMargin,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'multiAssetsMargin': multiAssetsMargin.toString(),
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/multiAssetsMargin',
      type: RequestType.POST,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : const Right(true));
  }

  /// Get user's position mode (Hedge Mode or One-way Mode ) on EVERY symbol
  Future<Either<String, bool>> getCurrentMultiAssetMode({
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/multiAssetsMargin',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then(
        (r) => r.isLeft ? Left(r.left) : Right(r.right['multiAssetsMargin']));
  }

  /// Send in a new order.
  ///
  /// https://binance-docs.github.io/apidocs/futures/en/#new-order-trade
  /// Additional mandatory parameters based on type:
  /// LIMIT : timeInForce, quantity, price |
  /// MARKET : quantity |
  /// STOP/TAKE_PROFIT : quantity, price, stopPrice |
  /// STOP_MARKET/TAKE_PROFIT_MARKET : stopPrice |
  /// TRAILING_STOP_MARKET : callbackRate
  Future<Either<String, Order>> newOrder({
    required String symbol,
    required Side side,
    PositionSide? positionSide,
    required OrderType type,
    TimeInForce? timeInForce,
    String? quantity,
    bool? reduceOnly,
    String? price,
    String? newClientOrderId,
    String? stopPrice,
    bool? closePosition,
    String? activationPrice,
    String? callbackRate,
    String? workingType,
    String? newOrderRespType,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
      'side': side.toStr(),
      'type': type.toStr(),
    };
    if (positionSide != null) params['positionSide'] = positionSide.toStr();
    if (price != null) params['price'] = price;
    if (quantity != null) params['quantity'] = quantity;
    if (timeInForce != null) params['timeInForce'] = timeInForce.toStr();
    if (reduceOnly != null) params['reduceOnly'] = reduceOnly.toString();
    if (newClientOrderId != null) params['newClientOrderId'] = newClientOrderId;
    if (stopPrice != null) params['stopPrice'] = stopPrice;
    if (closePosition != null)
      params['closePosition'] = closePosition.toString();
    if (activationPrice != null) params['activationPrice'] = activationPrice;
    if (callbackRate != null) params['callbackRate'] = callbackRate;
    if (workingType != null) params['workingType'] = workingType;
    if (newOrderRespType != null) params['newOrderRespType'] = newOrderRespType;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/order',
      type: RequestType.POST,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(Order.fromMap(r.right)));
  }

  /// Check an order's status.
  ///
  /// Either orderId or origClientOrderId must be sent.
  /// These orders will not be found:
  /// order status is CANCELED or EXPIRED, AND
  /// order has NO filled trade, AND
  /// created time + 7 days < current time

  Future<Either<String, Order>> queryOrder({
    required String symbol,
    int? orderId,
    String? origClientOrderId,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (orderId != null) params['orderId'] = orderId.toString();
    if (origClientOrderId != null)
      params['origClientOrderId'] = origClientOrderId;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/order',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(Order.fromMap(r.right)));
  }

  /// Cancel an active order.
  ///
  /// Either orderId or origClientOrderId must be sent.
  Future<Either<String, Order>> cancelOrder({
    required String symbol,
    int? orderId,
    String? origClientOrderId,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (orderId != null) params['orderId'] = orderId.toString();
    if (origClientOrderId != null)
      params['origClientOrderId'] = origClientOrderId;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/order',
      type: RequestType.DELETE,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(Order.fromMap(r.right)));
  }

  /// Cancel all open orders
  Future<Either<String, bool>> cancelAllOpenOrders({
    required String symbol,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/allOpenOrders',
      type: RequestType.DELETE,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : const Right(true));
  }

  /// EitherorderId or origClientOrderId must be sent
  ///
  /// If the queried order has been filled or cancelled, the error message "Order does not exist" will be returned.
  Future<Either<String, Order>> queryCurrentOpenOrder({
    required String symbol,
    int? orderId,
    String? origClientOrderId,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (orderId != null) params['orderId'] = orderId.toString();
    if (origClientOrderId != null)
      params['origClientOrderId'] = origClientOrderId;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/openOrder',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(Order.fromMap(r.right)));
  }

  /// Get all open orders on a symbol. Careful when accessing this with no symbol.
  ///
  /// If the symbol is not sent, orders for all symbols will be returned in an array.
  Future<Either<String, List<Order>>> currentAllOpenOrders({
    String? symbol,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (symbol != null) params['symbol'] = symbol;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/openOrders',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Order>.from(r.right.map((e) => Order.fromMap(e)))));
  }

  /// Get all account orders; active, canceled, or filled.
  ///
  /// These orders will not be found:
  /// order status is CANCELED or EXPIRED, AND
  /// order has NO filled trade, AND
  /// created time + 7 days < current time
  ///
  /// If orderId is set, it will get orders >= that orderId. Otherwise most recent orders are returned.
  /// The query time period must be less then 7 days( default as the recent 7 days).
  Future<Either<String, List<Order>>> allOrders({
    required String symbol,
    int? orderId,
    int? startTime,
    int? endTime,
    int? limit,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (orderId != null) params['orderId'] = orderId.toString();
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/allOrders',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Order>.from(r.right.map((e) => Order.fromMap(e)))));
  }

  /// Get futures account balances
  Future<Either<String, List<Balance>>> futureAccountBalance({
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v2/balance',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Balance>.from(r.right.map((e) => Balance.fromMap(e)))));
  }

  /// Get current account information.
  ///
  /// User in single-asset/ multi-assets mode will see different value, see comments in response section for detail.
  Future<Either<String, AccountInfo>> accountInformation({
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v2/account',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then(
        (r) => r.isLeft ? Left(r.left) : Right(AccountInfo.fromMap(r.right)));
  }

  /// Change user's initial leverage of specific symbol market.
  Future<Either<String, LeverageInfo>> changeInitialLeverage({
    required String symbol,
    required int leverage,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
      'leverage': leverage.toString(),
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/leverage',
      type: RequestType.POST,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then(
        (r) => r.isLeft ? Left(r.left) : Right(LeverageInfo.fromMap(r.right)));
  }

  /// Get current position information.
  ///
  /// Please use with user data stream ACCOUNT_UPDATE to meet your timeliness and accuracy needs.
  Future<Either<String, List<PositionInfo>>> positionInformation({
    String? symbol,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (symbol != null) params['symbol'] = symbol;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v2/positionRisk',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<PositionInfo>.from(
            r.right.map((e) => PositionInfo.fromMap(e)))));
  }

  /// Get trades history for a specific account and symbol.
  ///
  /// If startTime and endTime are both not sent, then the last 7 days' data will be returned.
  /// The time between startTime and endTime cannot be longer than 7 days.
  /// The parameter fromId cannot be sent with startTime or endTime.
  Future<Either<String, List<FuturesTrade>>> accountTradeList({
    required String symbol,
    int? startTime,
    int? endTime,
    int? fromId,
    int? limit,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (fromId != null) params['fromId'] = fromId.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/userTrades',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<FuturesTrade>.from(
            r.right.map((e) => FuturesTrade.fromMap(e)))));
  }

  /// If neither startTime nor endTime is sent, the recent 7-day data will be returned.
  /// If incomeType is not sent, all kinds of flow will be returned
  /// "trandId" is unique in the same incomeType for a user
  ///
  /// incomeType can be "TRANSFER", "WELCOME_BONUS", "REALIZED_PNL", "FUNDING_FEE", "COMMISSION", "INSURANCE_CLEAR",
  /// "REFERRAL_KICKBACK", "COMMISSION_REBATE", "DELIVERED_SETTELMENT", "COIN_SWAP_DEPOSIT", "COIN_SWAP_WITHDRAW"
  Future<Either<String, List<Income>>> getIncomeHistory({
    String? symbol,
    String? incomeType,
    int? startTime,
    int? endTime,
    int? limit,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (symbol != null) params['symbol'] = symbol;
    if (incomeType != null) params['incomeType'] = incomeType;
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/income',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Income>.from(r.right.map((e) => Income.fromMap(e)))));
  }

  /// If "autoCloseType" is not sent, orders with both of the types will be returned
  /// If "startTime" is not sent, data within 7 days before "endTime" can be queried
  ///
  /// autoCloseType can be "LIQUIDATION" for liquidation orders or "ADL" for ADL orders.
  Future<Either<String, List<Order>>> forceOrders({
    String? symbol,
    String? autoCloseType,
    int? startTime,
    int? endTime,
    int? limit,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (symbol != null) params['symbol'] = symbol;
    if (autoCloseType != null) params['autoCloseType'] = autoCloseType;
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/forceOrders',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Order>.from(r.right.map((e) => Order.fromMap(e)))));
  }

  /// Get taker and maker comission rates
  Future<Either<String, ComissionRate>> commissionRate({
    required String symbol,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'fapi/v1/commissionRate',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then(
        (r) => r.isLeft ? Left(r.left) : Right(ComissionRate.fromMap(r.right)));
  }

  /// Get account leverage of a specific symbol.
  Future<Either<String, Leverage>> notionalAndLeverageBrackets({
    required String symbol,
    String? recvWindow,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow;
    return sendRequest(
      path: 'fapi/v1/leverageBracket',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(Leverage.fromMap(r.right)));
  }

  /// Get account leverage of all symbols.
  Future<Either<String, List<Leverage>>> allNotionalAndLeverageBrackets({
    String? recvWindow,
  }) {
    Map<String, String> params = {};
    if (recvWindow != null) params['recvWindow'] = recvWindow;
    return sendRequest(
      path: 'fapi/v1/leverageBracket',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Leverage>.from(r.right.map((e) => Leverage.fromMap(e)))));
  }
}
