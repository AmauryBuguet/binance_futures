import 'package:binance_futures/src/common/classes.dart';
import 'package:binance_futures/src/common/enums.dart';
import 'package:either_dart/either.dart';

import '../classes.dart';
import '../enums.dart';
import '/src/binance_futures_api.dart';

/// Market Data Endpoints for Binance Spot API
extension MarketEndpoints on BinanceFutures {
  /// Test connectivity to the Rest API.
  Future<Either<String, bool>> testPing() => sendRequest(
        path: 'fapi/v1/ping',
        type: RequestType.GET,
      ).then((r) => r.isRight ? const Right(true) : Left(r.left));

  /// Test connectivity to the Rest API and get the current server time.
  Future<Either<String, int>> serverTime() => sendRequest(
        path: 'fapi/v1/time',
        type: RequestType.GET,
      ).then((r) => r.isRight ? Right(r.right['serverTime']) : Left(r.left));

  /// Get Binance futures exchange info
  Future<Either<String, ExchangeInfo>> exchangeInformation() {
    return sendRequest(
      path: 'fapi/v1/exchangeInfo',
      type: RequestType.GET,
    ).then(
        (r) => r.isLeft ? Left(r.left) : Right(ExchangeInfo.fromMap(r.right)));
  }

  /// Get Binance futures orderbook
  Future<Either<String, Orderbook>> orderBook({
    required String symbol,
    int? limit,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (limit != null) params['limit'] = limit.toString();
    return sendRequest(
      path: 'fapi/v1/depth',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft ? Left(r.left) : Right(Orderbook.fromMap(r.right)));
  }

  /// Get list of recent trades
  Future<Either<String, List<Trade>>> recentTradesList({
    required String symbol,
    int? limit,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (limit != null) params['limit'] = limit.toString();
    return sendRequest(
      path: 'fapi/v1/trades',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Trade>.from(r.right.map((e) => Trade.fromMap(e)))));
  }

  /// Get older market trades.
  ///
  /// This endpoint need your API key only, not the secret key.
  Future<Either<String, List<Trade>>> oldTradesLookup({
    required String symbol,
    int? limit,
    int? fromId,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (limit != null) params['limit'] = limit.toString();
    if (fromId != null) params['fromId'] = fromId.toString();
    return sendRequest(
      path: 'fapi/v1/historicalTrades',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Trade>.from(r.right.map((e) => Trade.fromMap(e)))));
  }

  /// Get compressed, aggregate trades.
  ///
  /// Trades that fill at the time, from the same order, with the same price will have the quantity aggregated.
  Future<Either<String, List<AggregatedTrade>>> compressedAggregateTradesList({
    required String symbol,
    int? fromId,
    int? startTime,
    int? endTime,
    int? limit,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (fromId != null) params['fromId'] = fromId.toString();
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    return sendRequest(
      path: 'fapi/v1/aggTrades',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<AggregatedTrade>.from(
            r.right.map((e) => AggregatedTrade.fromMap(e)))));
  }

  /// Kline/candlestick bars for a symbol.
  ///
  /// Klines are uniquely identified by their open time.
  Future<Either<String, List<Kline>>> candlestickData({
    required String symbol,
    required Interval interval,
    int? startTime,
    int? endTime,
    int? limit,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
      'interval': interval.toStr(),
    };
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    return sendRequest(
      path: 'fapi/v1/klines',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Kline>.from(r.right.map((e) => Kline.fromList(e)))));
  }

  /// Kline/candlestick bars for a symbol.
  ///
  /// Klines are uniquely identified by their open time.
  Future<Either<String, List<Kline>>> continuousContractKlineCandlestickData({
    required String pair,
    required String contractType,
    required Interval interval,
    int? startTime,
    int? endTime,
    int? limit,
  }) {
    Map<String, String> params = {
      'pair': pair,
      'contractType': contractType,
      'interval': interval.toStr(),
    };
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    return sendRequest(
      path: 'fapi/v1/continuousKlines',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Kline>.from(r.right.map((e) => Kline.fromList(e)))));
  }

  /// Kline/candlestick bars for the index price of a pair.
  ///
  /// Klines are uniquely identified by their open time.
  Future<Either<String, List<Kline>>> indexPriceKlineCandlestickData({
    required String pair,
    required Interval interval,
    int? startTime,
    int? endTime,
    int? limit,
  }) {
    Map<String, String> params = {
      'pair': pair,
      'interval': interval.toStr(),
    };
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    return sendRequest(
      path: 'fapi/v1/indexPriceKlines',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Kline>.from(r.right.map((e) => Kline.fromList(e)))));
  }

  /// Kline/candlestick bars for the mark price of a symbol.
  ///
  /// Klines are uniquely identified by their open time.
  Future<Either<String, List<Kline>>> markPriceKlineCandlestickData({
    required String symbol,
    required Interval interval,
    int? startTime,
    int? endTime,
    int? limit,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
      'interval': interval.toStr(),
    };
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    return sendRequest(
      path: 'fapi/v1/markPriceKlines',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Kline>.from(r.right.map((e) => Kline.fromList(e)))));
  }

  /// Mark Price and Funding Rate
  ///
  /// Weight: 1
  Future<Either<String, PremiumIndex>> premiumIndex({
    required String symbol,
  }) {
    Map<String, String> params = {'symbol': symbol};
    return sendRequest(
      path: 'fapi/v1/premiumIndex',
      type: RequestType.GET,
      params: params,
    ).then(
        (r) => r.isLeft ? Left(r.left) : Right(PremiumIndex.fromMap(r.right)));
  }

  /// Mark Price and Funding Rate for all tickers
  Future<Either<String, List<PremiumIndex>>> allPremiumIndexes() {
    return sendRequest(
      path: 'fapi/v1/premiumIndex',
      type: RequestType.GET,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<PremiumIndex>.from(
            r.right.map((e) => PremiumIndex.fromMap(e)))));
  }

  /// Get Funding Rate for one or all symbol(s)
  ///
  /// If startTime and endTime are not sent, the most recent limit datas are returned.
  /// If the number of data between startTime and endTime is larger than limit, return as startTime + limit.
  /// In ascending order.
  Future<Either<String, List<FundingRate>>> getFundingRateHistory({
    String? symbol,
    int? startTime,
    int? endTime,
    int? limit,
  }) {
    Map<String, String> params = {};
    if (symbol != null) params['symbol'] = symbol;
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    return sendRequest(
      path: 'fapi/v1/fundingRate',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<FundingRate>.from(
            r.right.map((e) => FundingRate.fromMap(e)))));
  }

  /// 24 hour rolling window price change statistics.
  ///
  /// Weight: 1
  Future<Either<String, Ticker24hStatistics>> ticker24hPriceChangeStatistics({
    required String symbol,
  }) {
    Map<String, String> params = {symbol: symbol};
    return sendRequest(
      path: 'fapi/v1/ticker/24hr',
      type: RequestType.GET,
      params: params,
    ).then((r) =>
        r.isLeft ? Left(r.left) : Right(Ticker24hStatistics.fromMap(r.right)));
  }

  /// 24 hour rolling window price change statistics.
  ///
  /// Careful when accessing this with no symbol.
  /// Weight: 40
  Future<Either<String, List<Ticker24hStatistics>>>
      allTickers24hPriceChangeStatistics() {
    return sendRequest(
      path: 'fapi/v1/ticker/24hr',
      type: RequestType.GET,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Ticker24hStatistics>.from(
            r.right.map((e) => Ticker24hStatistics.fromMap(e)))));
  }

  /// Latest price for a symbol.
  Future<Either<String, TickerPrice>> symbolPriceTicker({
    required String symbol,
  }) {
    Map<String, String> params = {'symbol': symbol};
    return sendRequest(
      path: 'fapi/v1/ticker/24hr',
      type: RequestType.GET,
      params: params,
    ).then(
        (r) => r.isLeft ? Left(r.left) : Right(TickerPrice.fromMap(r.right)));
  }

  /// Latest price for all symbols.
  Future<Either<String, List<TickerPrice>>> allSymbolsPriceTicker() {
    return sendRequest(
      path: 'fapi/v1/ticker/24hr',
      type: RequestType.GET,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<TickerPrice>.from(
            r.right.map((e) => TickerPrice.fromMap(e)))));
  }

  /// Best price/qty on the order book for a symbol.
  Future<Either<String, BookTicker>> symbolOrderBookTicker({
    required String symbol,
  }) {
    Map<String, String> params = {'symbol': symbol};
    return sendRequest(
      path: 'fapi/v1/ticker/bookTicker',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft ? Left(r.left) : Right(BookTicker.fromMap(r.right)));
  }

  /// Best price/qty on the order book for all symbols.
  Future<Either<String, List<BookTicker>>> allSymbolsOrderBookTicker() {
    return sendRequest(
      path: 'fapi/v1/ticker/bookTicker',
      type: RequestType.GET,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(
            List<BookTicker>.from(r.right.map((e) => BookTicker.fromMap(e)))));
  }

  /// Get present open interest of a specific symbol.
  Future<Either<String, OpenInterest>> openInterest({
    required String symbol,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    return sendRequest(
      path: 'fapi/v1/openInterest',
      type: RequestType.GET,
      params: params,
    ).then(
        (r) => r.isLeft ? Left(r.left) : Right(OpenInterest.fromMap(r.right)));
  }

  /// Get present open interest of a specific symbol.
  Future<Either<String, List<OpenInterestStatistics>>> openInterestStatistics({
    required String symbol,
    required String period,
    int? limit,
    int? startTime,
    int? endTime,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
      'period': period,
    };
    if (limit != null) params['limit'] = limit.toString();
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    return sendRequest(
      path: 'futures/data/openInterestHist',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<OpenInterestStatistics>.from(
            r.right.map((e) => OpenInterestStatistics.fromMap(e)))));
  }

  /// Get top traders Long/Short Ratio (Accounts).
  Future<Either<String, List<LongShortRatio>>> topTraderLongShortAccountRatio({
    required String symbol,
    required String period,
    int? limit,
    int? startTime,
    int? endTime,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
      'period': period,
    };
    if (limit != null) params['limit'] = limit.toString();
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    return sendRequest(
      path: 'futures/data/topLongShortAccountRatio',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<LongShortRatio>.from(
            r.right.map((e) => LongShortRatio.fromMap(e)))));
  }

  /// Get top traders Long/Short Ratio (Positions).
  Future<Either<String, List<LongShortRatio>>> topTraderLongShortPositionRatio({
    required String symbol,
    required String period,
    int? limit,
    int? startTime,
    int? endTime,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
      'period': period,
    };
    if (limit != null) params['limit'] = limit.toString();
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    return sendRequest(
      path: 'futures/data/topLongShortPositionRatio',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<LongShortRatio>.from(
            r.right.map((e) => LongShortRatio.fromMap(e)))));
  }

  /// Get present open interest of a specific symbol.
  Future<Either<String, List<LongShortRatio>>> longShortRatio({
    required String symbol,
    required String period,
    int? limit,
    int? startTime,
    int? endTime,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
      'period': period,
    };
    if (limit != null) params['limit'] = limit.toString();
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    return sendRequest(
      path: 'futures/data/globalLongShortAccountRatio',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<LongShortRatio>.from(
            r.right.map((e) => LongShortRatio.fromMap(e)))));
  }

  /// Taker long/short ratio
  Future<Either<String, List<TakerLongShortRatio>>> takerBuySellVolume({
    required String symbol,
    required String period,
    int? limit,
    int? startTime,
    int? endTime,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
      'period': period,
    };
    if (limit != null) params['limit'] = limit.toString();
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    return sendRequest(
      path: 'futures/data/takerlongshortRatio',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<TakerLongShortRatio>.from(
            r.right.map((e) => TakerLongShortRatio.fromMap(e)))));
  }

  /// The BLVT NAV system is based on Binance Futures, so the endpoint is based on fapi
  Future<Either<String, List<Kline>>> historicalBLVTNAVKlineCandlestick({
    required String symbol,
    required Interval interval,
    int? startTime,
    int? endTime,
    int? limit,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
      'interval': interval.toStr(),
    };
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    return sendRequest(
      path: 'fapi/v1/lvtKlines',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Kline>.from(r.right.map((e) => Kline.fromList(e)))));
  }

  /// Get assets info for an index (or all indexes). Only for composite index symbols.
  Future<Either<String, List<IndexInfo>>> compositeIndexSymbolInformation({
    String? symbol,
  }) {
    Map<String, String> params = {};
    if (symbol != null) params['symbol'] = symbol;
    return sendRequest(
      path: 'fapi/v1/indexInfo',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(
            List<IndexInfo>.from(r.right.map((e) => IndexInfo.fromMap(e)))));
  }
}
