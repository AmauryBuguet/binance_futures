import 'package:binance_futures/src/common/enums.dart';

import '../common/classes.dart';
import 'enums.dart';

class WsAggTrade {
  String eventType;
  int eventTime;
  String symbol;
  int aggTradeID;
  double price;
  double quantity;
  int firstTradeID;
  int lastTradeID;
  int tradeTime;
  bool isBuyerMarketMaker;

  WsAggTrade.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        symbol = m['s'],
        aggTradeID = m['a'],
        price = double.parse(m['p']),
        quantity = double.parse(m['q']),
        firstTradeID = m['f'],
        lastTradeID = m['l'],
        tradeTime = m['T'],
        isBuyerMarketMaker = m['m'];
}

class WsKline {
  final int startTime;
  final int closeTime;
  final String symbol;
  final Interval? interval;
  final int firstTradeId;
  final int lastTradeId;
  final double open;
  final double high;
  final double close;
  final double low;
  final double baseAssetVolume;
  final int tradeCount;
  final bool isClosed;
  final double quoteAssetVolume;
  final double takerBuyBaseAssetVolume;
  final double takerBuyQuoteAssetVolume;
  WsKline.fromMap(Map m)
      : startTime = m['t'],
        closeTime = m['T'],
        symbol = m['s'],
        interval = (m['i'] as String).toIntervalEnum(),
        firstTradeId = m['f'],
        lastTradeId = m['L'],
        open = double.parse(m['o']),
        high = double.parse(m['h']),
        close = double.parse(m['c']),
        low = double.parse(m['l']),
        baseAssetVolume = double.parse(m['v']),
        tradeCount = m['n'],
        isClosed = m['x'],
        quoteAssetVolume = double.parse(m['q']),
        takerBuyBaseAssetVolume = double.parse(m['V']),
        takerBuyQuoteAssetVolume = double.parse(m['Q']);
}

class WsKlineEvent {
  final String eventType;
  final int eventTime;
  final String symbol;
  final WsKline kline;

  WsKlineEvent.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        symbol = m['s'],
        kline = WsKline.fromMap(m["k"]);
}

class WsContinuousKlineEvent {
  final String eventType;
  final int eventTime;
  final String pair;
  final ContractType contractType;
  final WsKline kline;

  WsContinuousKlineEvent.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        pair = m['ps'],
        contractType = (m['ct'] as String).toContractTypeEnum(),
        kline = WsKline.fromMap(m["k"]);
}

class WsMiniTicker {
  String eventType;
  int eventTime;
  String symbol;
  double close;
  double open;
  double high;
  double low;
  double volume;
  double quoteVolume;

  WsMiniTicker.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        symbol = m['s'],
        close = double.parse(m['c']),
        open = double.parse(m['o']),
        high = double.parse(m['h']),
        low = double.parse(m['l']),
        volume = double.parse(m['v']),
        quoteVolume = double.parse(m['q']);
}

class WsTicker {
  String eventType;
  int eventTime;
  String symbol;
  double priceChange;
  double prichePercentChange;
  double weightedAvgPrice;
  double firstTradePrice;
  double lastPrice;
  double lastQty;
  double bestBid;
  double bestBidQty;
  double bestAsk;
  double bestAskQty;
  double open;
  double high;
  double low;
  double volume;
  double quoteVolume;
  int statsOpenTime;
  int statsCloseTime;
  int firstTradeId;
  int lastTradeId;
  int numberOfTrades;

  WsTicker.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        symbol = m['s'],
        priceChange = double.parse(m['p']),
        prichePercentChange = double.parse(m['P']),
        weightedAvgPrice = double.parse(m['w']),
        firstTradePrice = double.parse(m['x']),
        lastPrice = double.parse(m['c']),
        lastQty = double.parse(m['Q']),
        bestBid = double.parse(m['b']),
        bestBidQty = double.parse(m['B']),
        bestAsk = double.parse(m['a']),
        bestAskQty = double.parse(m['A']),
        open = double.parse(m['o']),
        high = double.parse(m['h']),
        low = double.parse(m['l']),
        volume = double.parse(m['v']),
        quoteVolume = double.parse(m['q']),
        statsOpenTime = m['O'],
        statsCloseTime = m['C'],
        firstTradeId = m['F'],
        lastTradeId = m['L'],
        numberOfTrades = m['n'];
}

class WsOrderBook {
  String eventType;
  int updateId;
  int eventTime;
  int transactionTime;
  String symbol;
  double bestBid;
  double bestBidQty;
  double bestAsk;
  double bestAskQty;

  WsOrderBook.fromMap(Map m)
      : eventType = m['e'],
        updateId = m['u'],
        eventTime = m['E'],
        transactionTime = m['E'],
        symbol = m['s'],
        bestBid = double.parse(m['b']),
        bestBidQty = double.parse(m['B']),
        bestAsk = double.parse(m['a']),
        bestAskQty = double.parse(m['A']);
}

class WsDiffOrderBook {
  String eventType;
  int eventTime;
  int transactionTime;
  String symbol;
  int firstUpdateId;
  int finalUpdateId;
  int lastUpdateId;
  List<OrderbookOrder> bids;
  List<OrderbookOrder> asks;

  WsDiffOrderBook.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m["E"],
        symbol = m["s"],
        firstUpdateId = m["U"],
        finalUpdateId = m["u"],
        lastUpdateId = m["pu"],
        transactionTime = m['T'],
        bids = (m['b'] as List<dynamic>)
            .map((e) => OrderbookOrder.fromList(e))
            .toList(),
        asks = (m['a'] as List<dynamic>)
            .map((e) => OrderbookOrder.fromList(e))
            .toList();
}

class WsMarkPrice {
  String eventType;
  int eventTime;
  String symbol;
  double markPrice;
  double indexPrice;
  double estimatedSettlePrice;
  double fundingRate;
  int nextFundingTime;

  WsMarkPrice.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        symbol = m['s'],
        markPrice = double.parse(m['p']),
        indexPrice = double.parse(m['i']),
        estimatedSettlePrice = double.parse(m['P']),
        fundingRate = double.parse(m['r']),
        nextFundingTime = m['T'];
}

class WsLiquidationEvent {
  final String eventType;
  final int eventTime;
  final LiquidationOrder order;

  WsLiquidationEvent.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        order = LiquidationOrder.fromMap(m["o"]);
}

class LiquidationOrder {
  String symbol;
  String side;
  String orderType;
  String timeInForce;
  double origQty;
  double price;
  double avgPrice;
  String orderStatus;
  double lastFilledQty;
  double cumQty;
  int tradeTime;

  LiquidationOrder.fromMap(Map m)
      : symbol = m['s'],
        side = m['S'],
        orderType = m['o'],
        timeInForce = m['f'],
        origQty = double.parse(m['q']),
        price = double.parse(m['p']),
        avgPrice = double.parse(m['ap']),
        orderStatus = m['X'],
        lastFilledQty = double.parse(m['l']),
        cumQty = double.parse(m['z']),
        tradeTime = m['T'];
}

class WsListenKeyExpiredEvent {
  String eventType;
  int eventTime;

  WsListenKeyExpiredEvent.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'];
}

class WsPosition {
  String symbol;
  PositionSide side;
  double positionAmount;
  String marginType;
  double isolatedWallet;
  double markPrice;
  double unrealizedPnL;
  double maintenanceMarginRequired;

  WsPosition.fromMap(Map m)
      : symbol = m['s'],
        side = (m['ps'] as String).toPositionSideEnum(),
        positionAmount = double.parse(m['pa']),
        marginType = m['mt'],
        isolatedWallet = double.parse(m['iw']),
        markPrice = double.parse(m['mp']),
        unrealizedPnL = double.parse(m['up']),
        maintenanceMarginRequired = double.parse(m['mm']);
}

class WsMarginCallEvent {
  String eventType;
  int eventTime;
  double crossWalletBalance;
  List<WsPosition> marginCalledPositions;

  WsMarginCallEvent.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        crossWalletBalance = double.parse(m['cw']),
        marginCalledPositions = (m['p'] as List<dynamic>)
            .map((e) => WsPosition.fromMap(e))
            .toList();
}

class BalanceUpdate {
  String asset;
  double walletBalance;
  double crossWalletBalance;
  double balanceChange;

  BalanceUpdate.fromMap(Map m)
      : asset = m['a'],
        walletBalance = double.parse(m['wb']),
        crossWalletBalance = double.parse(m['cw']),
        balanceChange = double.parse(m['bc']);
}

class PositionUpdate {
  String symbol;
  double positionAmount;
  double entryPrice;
  double accumulatedRealized;
  double unrealizedPnL;
  String marginType;
  double isolatedWallet;
  PositionSide positionSide;

  PositionUpdate.fromMap(Map m)
      : symbol = m['s'],
        positionAmount = double.parse(m['pa']),
        entryPrice = double.parse(m['ep']),
        accumulatedRealized = double.parse(m['cr']),
        unrealizedPnL = double.parse(m['up']),
        marginType = m['mt'],
        isolatedWallet = double.parse(m['iw']),
        positionSide = (m['ps'] as String).toPositionSideEnum();
}

class UpdateData {
  String eventReasonType;
  List<BalanceUpdate> balanceUpdates;
  List<PositionUpdate> positionUpdates;

  UpdateData.fromMap(Map m)
      : eventReasonType = m['m'],
        balanceUpdates = (m['B'] as List<dynamic>)
            .map((e) => BalanceUpdate.fromMap(e))
            .toList(),
        positionUpdates = (m['P'] as List<dynamic>)
            .map((e) => PositionUpdate.fromMap(e))
            .toList();
}

class WsAccountUpdateEvent {
  String eventType;
  int eventTime;
  int transaction;
  UpdateData data;

  WsAccountUpdateEvent.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        transaction = m['T'],
        data = UpdateData.fromMap(m['a']);
}

class OrderUpdate {
  String symbol;
  String clientOrderId;
  Side side;
  OrderType orderType;
  TimeInForce timeinForce;
  double originalQuantity;
  double originalPrice;
  double averagePrice;
  double stopPrice;
  ExecutionType executionType;
  OrderStatus orderStatus;
  int orderId;
  double orderLastFilledQuantity;
  double orderFilledAccumulatedQuantity;
  double lastFilledPrice;
  String commissionAsset;
  double commission;
  int tradeTime;
  int tradeId;
  double bidsNotional;
  double askNotional;
  bool isMakerSide;
  bool isReduceOnly;
  String stopPriceWorkingType;
  OrderType originalOrderType;
  PositionSide positionSide;
  bool isCloseAll;
  double activationPrice;
  double callbackRate;
  double realizedProfit;

  OrderUpdate.fromMap(Map m)
      : symbol = m['s'],
        clientOrderId = m['c'],
        side = (m['S'] as String).toSideEnum(),
        orderType = (m['o'] as String).toOrderTypeEnum(),
        timeinForce = (m['f'] as String).toTimeInForceEnum(),
        originalQuantity = double.parse(m['q']),
        originalPrice = double.parse(m['p']),
        averagePrice = double.parse(m['ap']),
        stopPrice = double.parse(m['sp'] ?? "0"),
        executionType = (m['x'] as String).toExecutionTypeEnum(),
        orderStatus = (m['X'] as String).toOrderStatusEnum(),
        orderId = m['i'],
        orderLastFilledQuantity = double.parse(m['l']),
        orderFilledAccumulatedQuantity = double.parse(m['z']),
        lastFilledPrice = double.parse(m['L']),
        commissionAsset = m['N'] ?? "",
        commission = double.parse(m['n'] ?? "0"),
        tradeTime = m['T'],
        tradeId = m['t'],
        bidsNotional = double.parse(m['b']),
        askNotional = double.parse(m['a']),
        isMakerSide = m['m'],
        isReduceOnly = m['R'],
        stopPriceWorkingType = m['wt'],
        originalOrderType = (m['ot'] as String).toOrderTypeEnum(),
        positionSide = (m['ps'] as String).toPositionSideEnum(),
        isCloseAll = m['cp'] ?? false,
        activationPrice = double.parse(m['AP'] ?? "0"),
        callbackRate = double.parse(m['cr'] ?? "0"),
        realizedProfit = double.parse(m['rp']);
}

class WsOrderUpdateEvent {
  String eventType;
  int eventTime;
  int transactionTime;
  OrderUpdate orderUpdate;

  WsOrderUpdateEvent.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        transactionTime = m['T'],
        orderUpdate = OrderUpdate.fromMap(m['o']);
}

class LeverageUpdate {
  String symbol;
  int leverage;

  LeverageUpdate.fromMap(Map m)
      : symbol = m['s'],
        leverage = m['l'];
}

class WsLeverageUpdateEvent {
  String eventType;
  int eventTime;
  int transactionTime;
  LeverageUpdate leverageUpdate;

  WsLeverageUpdateEvent.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        transactionTime = m['T'],
        leverageUpdate = LeverageUpdate.fromMap(m['ac']);
}

class AccountConfig {
  bool multiAssetsMode;

  AccountConfig.fromMap(Map m) : multiAssetsMode = m['j'];
}

class WsAccountConfigUpdateEvent {
  String eventType;
  int eventTime;
  int transactionTime;
  AccountConfig accountConfig;

  WsAccountConfigUpdateEvent.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        transactionTime = m['T'],
        accountConfig = AccountConfig.fromMap(m['ai']);
}
