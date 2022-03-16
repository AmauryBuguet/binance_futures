import 'package:binance_futures/src/common/classes.dart';
import 'package:binance_futures/src/common/enums.dart';

class Symbol {
  String symbol;
  String pair;
  String contractType;
  int deliveryDate;
  int onboardDate;
  String status;
  String baseAsset;
  String quoteAsset;
  String marginAsset;
  int pricePrecision;
  int quantityPrecision;
  int baseAssetPrecision;
  int quotePrecision;
  String underlyingType;
  List<String> underlyingSubType;
  int settlePlan;
  double triggerProtect;
  List<Filter> filters;
  List<OrderType> orderTypes;
  List<TimeInForce> timeInForceList;
  double liquidationFee;
  double marketTakeBound;

  Symbol.fromMap(Map m)
      : symbol = m['symbol'],
        pair = m['pair'] ?? "",
        contractType = m['contractType'] ?? "",
        deliveryDate = m['deliveryDate'] ?? 0,
        onboardDate = m['onboardDate'] ?? 0,
        status = m['status'] ?? "",
        baseAsset = m['baseAsset'],
        quoteAsset = m['quoteAsset'],
        marginAsset = m['marginAsset'] ?? "",
        pricePrecision = m['pricePrecision'] ?? 1,
        quantityPrecision = m['quantityPrecision'] ?? 1,
        baseAssetPrecision = m['baseAssetPrecision'],
        quotePrecision = m['quotePrecision'],
        underlyingType = m['underlyingType'] ?? "",
        underlyingSubType = m['underlyingSubType'] is List<String>
            ? m['underlyingSubType']
            : [],
        settlePlan = m['settlePlan'] ?? 0,
        triggerProtect = m.containsKey('triggerProtect')
            ? double.parse(m['triggerProtect'])
            : 0,
        filters = (m['filters'] as List<dynamic>)
            .map((e) => Filter.fromMap(e))
            .toList(),
        orderTypes = m['OrderType'] is List<String>
            ? (m['OrderType'] as List<String>)
                .map((e) => e.toOrderTypeEnum())
                .toList()
            : [],
        timeInForceList = m['timeInForce'] is List<String>
            ? (m['timeInForce'] as List<String>)
                .map((e) => e.toTimeInForceEnum())
                .toList()
            : [],
        liquidationFee = m.containsKey("liquidationFee")
            ? double.parse(m['liquidationFee'])
            : 0,
        marketTakeBound = m.containsKey('marketTakeBound')
            ? double.parse(m['marketTakeBound'])
            : 0;
}

class Filter {
  String type;
  Map<String, dynamic> data;
  Filter.fromMap(m)
      : type = m["filterType"],
        data = m;
}

class RateLimit {
  String interval;
  int intervalNum;
  int limit;
  String rateLimitType;

  RateLimit.fromMap(Map m)
      : interval = m['interval'],
        intervalNum = m['intervalNum'],
        limit = m['limit'],
        rateLimitType = m['rateLimitType'];
}

class AssetInfo {
  String asset;
  bool marginAvailable;
  dynamic autoAssetExchange;

  AssetInfo.fromMap(Map m)
      : asset = m['asset'],
        marginAvailable = m['marginAvailable'],
        autoAssetExchange = m['autoAssetExchange'];
}

class ExchangeInfo {
  List<dynamic> exchangeFilters;
  List<RateLimit> rateLimits;
  int serverTime;
  List<AssetInfo> assets;
  List<Symbol> symbols;
  String timezone;

  ExchangeInfo.fromMap(Map m)
      : exchangeFilters = m['exchangeFilters'],
        rateLimits = (m['rateLimits'] as List<dynamic>)
            .map((e) => RateLimit.fromMap(e))
            .toList(),
        serverTime = m['serverTime'],
        assets = (m['assets'] as List<dynamic>)
            .map((e) => AssetInfo.fromMap(e))
            .toList(),
        symbols = (m['symbols'] as List<dynamic>)
            .map((e) => Symbol.fromMap(e))
            .toList(),
        timezone = m['timezone'];
}

class Orderbook {
  int lastUpdateId;
  int E;
  int T;
  List<OrderbookOrder> bids;
  List<OrderbookOrder> asks;

  Orderbook.fromMap(Map m)
      : lastUpdateId = m['lastUpdateId'],
        E = m['E'],
        T = m['T'],
        bids = (m['bids'] as List<dynamic>)
            .map((e) => OrderbookOrder.fromList(e))
            .toList(),
        asks = (m['asks'] as List<dynamic>)
            .map((e) => OrderbookOrder.fromList(e))
            .toList();
}

class Trade {
  int id;
  double price;
  double qty;
  double quoteQty;
  int time;
  bool isBuyerMaker;

  Trade.fromMap(Map m)
      : id = m['id'],
        price = double.parse(m['price']),
        qty = double.parse(m['qty']),
        quoteQty = double.parse(m['quoteQty']),
        time = m['time'],
        isBuyerMaker = m['isBuyerMaker'];
}

class Kline {
  int openTime;
  double open;
  double high;
  double low;
  double close;
  double qty;
  int closeTime;
  double quoteAssetQty;
  int tradesCount;
  double takerBuyBaseAssetQty;
  double takerBuyQuoteAssetQty;

  Kline.fromList(List l)
      : openTime = l[0],
        open = double.parse(l[1]),
        high = double.parse(l[2]),
        low = double.parse(l[3]),
        close = double.parse(l[4]),
        qty = double.parse(l[5]),
        closeTime = l[6],
        quoteAssetQty = double.parse(l[7]),
        tradesCount = l[8],
        takerBuyBaseAssetQty = double.parse(l[9]),
        takerBuyQuoteAssetQty = double.parse(l[10]);
}

class PremiumIndex {
  String symbol;
  double markPrice;
  double indexPrice;
  double estimatedSettlePrice;
  double lastFundingRate;
  int nextFundingTime;
  double interestRate;
  int time;

  PremiumIndex.fromMap(Map m)
      : symbol = m['symbol'],
        markPrice = double.parse(m['markPrice']),
        indexPrice = double.parse(m['indexPrice']),
        estimatedSettlePrice = double.parse(m['estimatedSettlePrice']),
        lastFundingRate = double.parse(m['lastFundingRate']),
        nextFundingTime = m['nextFundingTime'],
        interestRate = double.parse(m['interestRate']),
        time = m['time'];
}

class FundingRate {
  String symbol;
  double fundingRate;
  int fundingTime;

  FundingRate.fromMap(Map m)
      : symbol = m['symbol'],
        fundingRate = double.parse(m['fundingRate']),
        fundingTime = m['fundingTime'];
}

class Ticker24hStatistics {
  String symbol;
  double priceChange;
  double priceChangePercent;
  double weightedAvgPrice;
  double prevClosePrice;
  double lastPrice;
  double lastQty;
  double openPrice;
  double highPrice;
  double lowPrice;
  double volume;
  double quoteVolume;
  int openTime;
  int closeTime;
  int firstId;
  int lastId;
  int count;

  Ticker24hStatistics.fromMap(Map m)
      : symbol = m['symbol'],
        priceChange = double.parse(m['priceChange']),
        priceChangePercent = double.parse(m['priceChangePercent']),
        weightedAvgPrice = double.parse(m['weightedAvgPrice']),
        prevClosePrice = double.parse(m['prevClosePrice']),
        lastPrice = double.parse(m['lastPrice']),
        lastQty = double.parse(m['lastQty']),
        openPrice = double.parse(m['openPrice']),
        highPrice = double.parse(m['highPrice']),
        lowPrice = double.parse(m['lowPrice']),
        volume = double.parse(m['volume']),
        quoteVolume = double.parse(m['quoteVolume']),
        openTime = m['openTime'],
        closeTime = m['closeTime'],
        firstId = m['firstId'],
        lastId = m['lastId'],
        count = m['count'];
}

class TickerPrice {
  String symbol;
  double price;
  int time;

  TickerPrice.fromMap(Map m)
      : symbol = m['symbol'],
        price = double.parse(m['price']),
        time = m['time'];
}

class BookTicker {
  String symbol;
  double bidPrice;
  double bidQty;
  double askPrice;
  double askQty;
  int time;

  BookTicker.fromMap(Map m)
      : symbol = m['symbol'],
        bidPrice = double.parse(m['bidPrice']),
        bidQty = double.parse(m['bidQty']),
        askPrice = double.parse(m['askPrice']),
        askQty = double.parse(m['askQty']),
        time = m['time'];
}

class OpenInterest {
  double openInterest;
  String symbol;
  int time;

  OpenInterest.fromMap(Map m)
      : openInterest = double.parse(m['openInterest']),
        symbol = m['symbol'],
        time = m['time'];
}

class OpenInterestStatistics {
  String symbol;
  double sumOpenInterest;
  double sumOpenInterestValue;
  double timestamp;

  OpenInterestStatistics.fromMap(Map m)
      : symbol = m['symbol'],
        sumOpenInterest = double.parse(m['sumOpenInterest']),
        sumOpenInterestValue = double.parse(m['sumOpenInterestValue']),
        timestamp = double.parse(m['timestamp']);
}

class LongShortRatio {
  String symbol;
  double longShortRatio;
  double longAccount;
  double shortAccount;
  double timestamp;

  LongShortRatio.fromMap(Map m)
      : symbol = m['symbol'],
        longShortRatio = double.parse(m['longShortRatio']),
        longAccount = double.parse(m['longAccount']),
        shortAccount = double.parse(m['shortAccount']),
        timestamp = double.parse(m['timestamp']);
}

class TakerLongShortRatio {
  double buySellRatio;
  double buyVol;
  double sellVol;
  double timestamp;

  TakerLongShortRatio.fromMap(Map m)
      : buySellRatio = double.parse(m['buySellRatio']),
        buyVol = double.parse(m['buyVol']),
        sellVol = double.parse(m['sellVol']),
        timestamp = double.parse(m['timestamp']);
}

class IndexAsset {
  String baseAsset;
  String quoteAsset;
  double weightInQuantity;
  double weightInPercentage;

  IndexAsset.fromMap(Map m)
      : baseAsset = m['baseAsset'],
        quoteAsset = m['quoteAsset'],
        weightInQuantity = double.parse(m['weightInQuantity']),
        weightInPercentage = double.parse(m['weightInPercentage']);
}

class IndexInfo {
  String symbol;
  int time;
  String component;
  List<IndexAsset> baseAssetList;

  IndexInfo.fromMap(Map m)
      : symbol = m['symbol'],
        time = m['time'],
        component = m['component'],
        baseAssetList = (m['baseAssetList'] as List<dynamic>)
            .map((e) => IndexAsset.fromMap(e))
            .toList();
}

class Order {
  String clientOrderId;
  double cumQty;
  double cumQuote;
  double executedQty;
  int orderId;
  double avgPrice;
  double origQty;
  double price;
  bool reduceOnly;
  Side side;
  PositionSide positionSide;
  OrderStatus status;
  double stopPrice;
  bool closePosition;
  String symbol;
  TimeInForce timeInForce;
  OrderType type;
  OrderType origType;
  double activatePrice;
  double priceRate;
  int updateTime;
  String workingType;
  bool priceProtect;
  int time;

  Order.fromMap(Map m)
      : clientOrderId = m['clientOrderId'],
        cumQty = double.parse(m['cumQty'] ?? "0"),
        time = m['time'] ?? 0,
        cumQuote = double.parse(m['cumQuote']),
        executedQty = double.parse(m['executedQty']),
        orderId = m['orderId'],
        avgPrice = double.parse(m['avgPrice']),
        origQty = double.parse(m['origQty']),
        price = double.parse(m['price']),
        reduceOnly = m['reduceOnly'],
        side = (m['side'] as String).toSideEnum(),
        positionSide = (m['positionSide'] as String).toPositionSideEnum(),
        status = (m['status'] as String).toOrderStatusEnum(),
        stopPrice = double.parse(m['stopPrice'] ?? "0"),
        closePosition = m['closePosition'] ?? false,
        symbol = m['symbol'],
        timeInForce = (m['timeInForce'] as String).toTimeInForceEnum(),
        type = (m['type'] as String).toOrderTypeEnum(),
        origType = (m['origType'] as String).toOrderTypeEnum(),
        activatePrice = double.parse(m['activatePrice'] ?? "0"),
        priceRate = double.parse(m['priceRate'] ?? "0"),
        updateTime = m['updateTime'],
        workingType = m['workingType'],
        priceProtect = m['priceProtect'] ?? false;
}

class Balance {
  String accountAlias;
  String asset;
  double balance;
  double crossWalletBalance;
  double crossUnPnl;
  double availableBalance;
  double maxWithdrawAmount;
  bool marginAvailable;
  int updateTime;

  Balance.fromMap(Map m)
      : accountAlias = m['accountAlias'],
        asset = m['asset'],
        balance = double.parse(m['balance']),
        crossWalletBalance = double.parse(m['crossWalletBalance']),
        crossUnPnl = double.parse(m['crossUnPnl']),
        availableBalance = double.parse(m['availableBalance']),
        maxWithdrawAmount = double.parse(m['maxWithdrawAmount']),
        marginAvailable = m['marginAvailable'],
        updateTime = m['updateTime'];
}

class FuturesAsset {
  String asset;
  double walletBalance;
  double unrealizedProfit;
  double marginBalance;
  double maintMargin;
  double initialMargin;
  double positionInitialMargin;
  double openOrderInitialMargin;
  double crossWalletBalance;
  double crossUnPnl;
  double availableBalance;
  double maxWithdrawAmount;
  bool marginAvailable;
  int updateTime;

  FuturesAsset.fromMap(Map m)
      : asset = m['asset'],
        walletBalance = double.parse(m['walletBalance']),
        unrealizedProfit = double.parse(m['unrealizedProfit']),
        marginBalance = double.parse(m['marginBalance']),
        maintMargin = double.parse(m['maintMargin']),
        initialMargin = double.parse(m['initialMargin']),
        positionInitialMargin = double.parse(m['positionInitialMargin']),
        openOrderInitialMargin = double.parse(m['openOrderInitialMargin']),
        crossWalletBalance = double.parse(m['crossWalletBalance']),
        crossUnPnl = double.parse(m['crossUnPnl']),
        availableBalance = double.parse(m['availableBalance']),
        maxWithdrawAmount = double.parse(m['maxWithdrawAmount']),
        marginAvailable = m['marginAvailable'],
        updateTime = m['updateTime'];
}

class FuturesPosition {
  String symbol;
  double initialMargin;
  double maintMargin;
  double unrealizedProfit;
  double positionInitialMargin;
  double openOrderInitialMargin;
  double leverage;
  bool isolated;
  double entryPrice;
  double maxNotional;
  PositionSide positionSide;
  double positionAmt;
  int updateTime;

  FuturesPosition.fromMap(Map m)
      : symbol = m['symbol'],
        initialMargin = double.parse(m['initialMargin']),
        maintMargin = double.parse(m['maintMargin']),
        unrealizedProfit = double.parse(m['unrealizedProfit']),
        positionInitialMargin = double.parse(m['positionInitialMargin']),
        openOrderInitialMargin = double.parse(m['openOrderInitialMargin']),
        leverage = double.parse(m['leverage']),
        isolated = m['isolated'],
        entryPrice = double.parse(m['entryPrice']),
        maxNotional = double.parse(m['maxNotional']),
        positionSide = (m['positionSide'] as String).toPositionSideEnum(),
        positionAmt = double.parse(m['positionAmt']),
        updateTime = m['updateTime'];
}

class AccountInfo {
  int feeTier;
  bool canTrade;
  bool canDeposit;
  bool canWithdraw;
  int updateTime;
  double totalInitialMargin;
  double totalMaintMargin;
  double totalWalletBalance;
  double totalUnrealizedProfit;
  double totalMarginBalance;
  double totalPositionInitialMargin;
  double totalOpenOrderInitialMargin;
  double totalCrossWalletBalance;
  double totalCrossUnPnl;
  double availableBalance;
  double maxWithdrawAmount;
  List<FuturesAsset> assets;
  List<FuturesPosition> positions;

  AccountInfo.fromMap(Map m)
      : feeTier = m['feeTier'],
        canTrade = m['canTrade'],
        canDeposit = m['canDeposit'],
        canWithdraw = m['canWithdraw'],
        updateTime = m['updateTime'],
        totalInitialMargin = double.parse(m['totalInitialMargin']),
        totalMaintMargin = double.parse(m['totalMaintMargin']),
        totalWalletBalance = double.parse(m['totalWalletBalance']),
        totalUnrealizedProfit = double.parse(m['totalUnrealizedProfit']),
        totalMarginBalance = double.parse(m['totalMarginBalance']),
        totalPositionInitialMargin =
            double.parse(m['totalPositionInitialMargin']),
        totalOpenOrderInitialMargin =
            double.parse(m['totalOpenOrderInitialMargin']),
        totalCrossWalletBalance = double.parse(m['totalCrossWalletBalance']),
        totalCrossUnPnl = double.parse(m['totalCrossUnPnl']),
        availableBalance = double.parse(m['availableBalance']),
        maxWithdrawAmount = double.parse(m['maxWithdrawAmount']),
        assets = (m['assets'] as List<dynamic>)
            .map((e) => FuturesAsset.fromMap(e))
            .toList(),
        positions = (m['positions'] as List<dynamic>)
            .map((e) => FuturesPosition.fromMap(e))
            .toList();
}

class LeverageInfo {
  int leverage;
  double maxNotionalValue;
  String symbol;

  LeverageInfo.fromMap(Map m)
      : leverage = m['leverage'],
        maxNotionalValue = double.parse(m['maxNotionalValue']),
        symbol = m['symbol'];
}

class PositionInfo {
  double entryPrice;
  String marginType;
  String isAutoAddMargin;
  double isolatedMargin;
  double leverage;
  double liquidationPrice;
  double markPrice;
  double maxNotionalValue;
  double positionAmt;
  String symbol;
  double unRealizedProfit;
  PositionSide positionSide;
  int updateTime;

  PositionInfo.fromMap(Map m)
      : entryPrice = double.parse(m['entryPrice']),
        marginType = m['marginType'],
        isAutoAddMargin = m['isAutoAddMargin'],
        isolatedMargin = double.parse(m['isolatedMargin']),
        leverage = double.parse(m['leverage']),
        liquidationPrice = double.parse(m['liquidationPrice']),
        markPrice = double.parse(m['markPrice']),
        maxNotionalValue = double.parse(m['maxNotionalValue']),
        positionAmt = double.parse(m['positionAmt']),
        symbol = m['symbol'],
        unRealizedProfit = double.parse(m['unRealizedProfit']),
        positionSide = (m['positionSide'] as String).toPositionSideEnum(),
        updateTime = m['updateTime'];
}

class FuturesTrade {
  bool buyer;
  double commission;
  String commissionAsset;
  int id;
  bool maker;
  int orderId;
  double price;
  double qty;
  double quoteQty;
  double realizedPnl;
  Side side;
  PositionSide positionSide;
  String symbol;
  int time;

  FuturesTrade.fromMap(Map m)
      : buyer = m['buyer'],
        commission = double.parse(m['commission']),
        commissionAsset = m['commissionAsset'],
        id = m['id'],
        maker = m['maker'],
        orderId = m['orderId'],
        price = double.parse(m['price']),
        qty = double.parse(m['qty']),
        quoteQty = double.parse(m['quoteQty']),
        realizedPnl = double.parse(m['realizedPnl']),
        side = (m['side'] as String).toSideEnum(),
        positionSide = (m['positionSide'] as String).toPositionSideEnum(),
        symbol = m['symbol'],
        time = m['time'];
}

class Income {
  String symbol;
  String incomeType;
  double income;
  String asset;
  String info;
  int time;
  double tranId;
  double tradeId;

  Income.fromMap(Map m)
      : symbol = m['symbol'],
        incomeType = m['incomeType'],
        income = double.parse(m['income']),
        asset = m['asset'],
        info = m['info'],
        time = m['time'],
        tranId = double.parse(m['tranId']),
        tradeId = double.parse(m['tradeId']);
}

class ComissionRate {
  String symbol;
  double makerCommissionRate;
  double takerCommissionRate;

  ComissionRate.fromMap(Map m)
      : symbol = m['symbol'],
        makerCommissionRate = double.parse(m['makerCommissionRate']),
        takerCommissionRate = double.parse(m['takerCommissionRate']);
}

class LeverageBracket {
  int bracket;
  int initialLeverage;
  int notionalCap;
  int notionalFloor;
  double maintMarginRatio;
  int cum;

  LeverageBracket.fromMap(Map m)
      : bracket = m['bracket'],
        initialLeverage = m['initialLeverage'],
        notionalCap = m['notionalCap'],
        notionalFloor = m['notionalFloor'],
        maintMarginRatio = double.parse(m['maintMarginRatio']),
        cum = m['cum'];
}

class Leverage {
  String symbol;
  List<LeverageBracket> brackets;

  Leverage.fromMap(Map m)
      : symbol = m['symbol'],
        brackets = (m['brackets'] as List<dynamic>)
            .map((e) => LeverageBracket.fromMap(e))
            .toList();
}
