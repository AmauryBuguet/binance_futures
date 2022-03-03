import 'package:binance_futures/src/common/enums.dart';
import 'package:binance_futures/src/websocket/enums.dart';

import '/src/binance_futures_api.dart';
import 'classes.dart';

extension MarketDataWebsockets on BinanceFutures {
  /// The Aggregate Trade Streams push trade information that is aggregated for a single taker order.
  Stream<WsAggTrade> aggregatedTradeStream({required String symbol}) {
    final channel = subscribe('${symbol.toLowerCase()}@aggTrade');
    return channel.stream
        .map<Map>(toMap)
        .map<WsAggTrade>((e) => WsAggTrade.fromMap(e));
  }

  /// Mark price and funding rate for a single symbol pushed every 3 seconds or every second.
  Stream<WsMarkPrice> markPriceStream({
    required String symbol,
    bool is1s = false,
  }) {
    final channel =
        subscribe('${symbol.toLowerCase()}@markPrice' + (is1s ? "@1s" : ""));
    return channel.stream
        .map<Map>(toMap)
        .map<WsMarkPrice>((e) => WsMarkPrice.fromMap(e));
  }

  /// Mark price and funding rate for all symbols pushed every 3 seconds or every second.
  Stream<List<WsMarkPrice>> allMarkPriceStream({
    bool is1s = false,
  }) {
    final channel = subscribe('!markPrice@arr' + (is1s ? "@1s" : ""));
    return channel.stream.map<List>(toList).map<List<WsMarkPrice>>(
        (e) => e.map((a) => WsMarkPrice.fromMap(a)).toList());
  }

  /// The Kline/Candlestick Stream push updates to the current klines/candlestick every second.
  Stream<WsKlineEvent> klineStream(
      {required String symbol, required Interval interval}) {
    final channel =
        subscribe('${symbol.toLowerCase()}@kline_${interval.toStr()}');
    return channel.stream
        .map<Map>(toMap)
        .map<WsKlineEvent>((e) => WsKlineEvent.fromMap(e));
  }

  /// Pushes updates of a contract continuous klines every second.
  Stream<WsContinuousKlineEvent> continuousKlineStream({
    required String pair,
    required Interval interval,
    required ContractType contractType,
  }) {
    final channel = subscribe(
        '${pair.toLowerCase()}_${contractType.toStr()}@continuousKline_${interval.toStr()}');
    return channel.stream
        .map<Map>(toMap)
        .map<WsContinuousKlineEvent>((e) => WsContinuousKlineEvent.fromMap(e));
  }

  /// 24hr rolling window mini-ticker statistics for a single symbol.
  ///
  /// These are NOT the statistics of the UTC day, but a 24hr rolling window from requestTime to 24hrs before.
  Stream<WsMiniTicker> miniTickerStream({required String symbol}) {
    final channel = subscribe('${symbol.toLowerCase()}@miniTicker');
    return channel.stream
        .map<Map>(toMap)
        .map<WsMiniTicker>((e) => WsMiniTicker.fromMap(e));
  }

  /// 24hr rolling window mini-ticker statistics for all symbols.
  ///
  /// These are NOT the statistics of the UTC day, but a 24hr rolling window from requestTime to 24hrs before.
  /// Note that only tickers that have changed will be present in the array.
  Stream<List<WsMiniTicker>> allMiniTickerStream() {
    final channel = subscribe('!miniTicker@arr');
    return channel.stream.map<List>(toList).map<List<WsMiniTicker>>(
        (e) => e.map((a) => WsMiniTicker.fromMap(a)).toList());
  }

  /// 24hr rolling window ticker statistics for a single symbol.
  ///
  /// These are NOT the statistics of the UTC day, but a 24hr rolling window for the previous 24hrs.
  Stream<WsTicker> tickerStream({required String symbol}) {
    final channel = subscribe('${symbol.toLowerCase()}@ticker');
    return channel.stream
        .map<Map>(toMap)
        .map<WsTicker>((e) => WsTicker.fromMap(e));
  }

  /// 24hr rolling window ticker statistics for all symbols.
  ///
  /// These are NOT the statistics of the UTC day, but a 24hr rolling window from requestTime to 24hrs before.
  /// Note that only tickers that have changed will be present in the array.
  Stream<List<WsTicker>> allTickerStream() {
    final channel = subscribe('!ticker@arr');
    return channel.stream
        .map<List>(toList)
        .map<List<WsTicker>>((e) => e.map((a) => WsTicker.fromMap(a)).toList());
  }

  /// Pushes any update to the best bid or ask's price or quantity in real-time for a specified symbol.
  Stream<WsOrderBook> orderbookStream({required String symbol}) {
    final channel = subscribe('${symbol.toLowerCase()}@bookTicker');
    return channel.stream
        .map<Map>(toMap)
        .map<WsOrderBook>((e) => WsOrderBook.fromMap(e));
  }

  /// Pushes any update to the best bid or ask's price or quantity in real-time for all symbols.
  Stream<WsOrderBook> allOrderbookStream() {
    final channel = subscribe('!bookTicker');
    return channel.stream
        .map<Map>(toMap)
        .map<WsOrderBook>((e) => WsOrderBook.fromMap(e));
  }

  /// The Liquidation Order Snapshot Streams push force liquidation order information for specific symbol.
  ///
  ///For each symbol，only the latest one liquidation order within 1000ms will be pushed as the snapshot.
  ///If no liquidation happens in the interval of 1000ms, no stream will be pushed.
  Stream<WsLiquidationEvent> liquidationStream({required String symbol}) {
    final channel = subscribe('${symbol.toLowerCase()}@forceorder');
    return channel.stream
        .map<Map>(toMap)
        .map<WsLiquidationEvent>((e) => WsLiquidationEvent.fromMap(e));
  }

  /// The All Liquidation Order Snapshot Streams push force liquidation order information for all symbols in the market.
  ///
  /// For each symbol，only the latest one liquidation order within 1000ms will be pushed as the snapshot.
  /// If no liquidation happens in the interval of 1000ms, no stream will be pushed.
  Stream<WsLiquidationEvent> allLiquidationStream() {
    final channel = subscribe('!forceOrder@arr');
    return channel.stream
        .map<Map>(toMap)
        .map<WsLiquidationEvent>((e) => WsLiquidationEvent.fromMap(e));
  }

  /// Top bids and asks, Valid are 5, 10, or 20.
  Stream<WsDiffOrderBook> partialOrderbookStream({
    required String symbol,
    required int nbLevel,
    bool is100ms = false,
    bool is500ms = false,
  }) {
    final channel = subscribe('${symbol.toLowerCase()}@depth$nbLevel' +
        (is500ms ? "@500ms" : (is100ms ? "@100ms" : "")));
    return channel.stream
        .map<Map>(toMap)
        .map<WsDiffOrderBook>((e) => WsDiffOrderBook.fromMap(e));
  }

  /// Order book price and quantity depth updates used to locally manage an order book.
  Stream<WsDiffOrderBook> diffOrderbookStream({
    required String symbol,
    bool is100ms = false,
    bool is500ms = false,
  }) {
    final channel = subscribe('${symbol.toLowerCase()}@depth' +
        (is500ms ? "@500ms" : (is100ms ? "@100ms" : "")));
    return channel.stream
        .map<Map>(toMap)
        .map<WsDiffOrderBook>((e) => WsDiffOrderBook.fromMap(e));
  }
}
