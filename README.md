# binance_futures

This is an unofficial Dart wrapper for Binance FUTURES API.  
For now it includes market, trade, and account endpoints, as well as support for market and user data streams.  
Feel free to submit pull requests I will be glad to accept them if they match the coding style.  
This library has been partially auto-generated (using a custom tool I made), so do not hesitate to submit an issue if you find one.  

## Currently supported :
* Market Data Endpoints (100%)
* Account / Trade Endpoints (50%)
* Websocket market streams (100%)
* User data streams (100%)

## Useful links
* [Binance API docs](https://binance-docs.github.io/apidocs/futures/en/)

## Getting Started
### Install
```yaml
dependencies:
  binance_futures: ^0.0.1
```

or to get the latest version
```yaml
dependencies:
  binance_futures:
   git: https://github.com/AmauryBuguet/binance_futures
```

or use
```
flutter pub add binance_futures
```

### Usage
```dart
import 'dart:async';

import 'package:binance_futures/binance_futures.dart';
import 'package:flutter/material.dart' hide Interval;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BinanceFutures binanceFutures = BinanceFutures(
    key: "<apiKey>",
    secret: "<apiSecret>",
  );
  double lastClosePrice = 0;
  String tradablePairs = "";
  String lastEventData = "";
  late StreamSubscription<dynamic> klineStreamSub;
  late StreamSubscription<dynamic> userdataStreamSub;
  @override
  void initState() {
    startKlineStream();
    startUserdataStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Binance API tester"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Current BTC price : $lastClosePrice"),
            Text("Last userdataStream event : $lastEventData"),
            TextButton(
              onPressed: getTradablePairs,
              child: const Text("GET PAIRS"),
            ),
            Expanded(
              flex: 1,
              child: SelectableText(
                tradablePairs,
                maxLines: 200,
                minLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startKlineStream() {
    var stream = binanceFutures.klineStream(
      symbol: "BTCUSDT",
      interval: Interval.INTERVAL_5m,
    );
    klineStreamSub = stream.listen(handleNewKline);
  }

  void handleNewKline(WsKlineEvent event) {
    setState(() {
      lastClosePrice = event.kline.close;
    });
  }

  void startUserdataStream() async {
    var response = await binanceFutures.createListenKey();
    if (response.isRight) {
      var stream = binanceFutures.userDataStream(listenKey: response.right);
      userdataStreamSub = stream.listen(handleUserdataEvent);
    } else {
      lastEventData = response.left;
    }
  }

  void handleUserdataEvent(dynamic event) {
    if (event is WsAccountUpdateEvent) {
      lastEventData = "Account update event : ${event.data.balanceUpdates.length} balances updated";
    } else if (event is WsOrderUpdateEvent) {
      lastEventData = "Order update event : order on ${event.orderUpdate.symbol} pair updated";
    } else {
      lastEventData = "Other event type : ${event.toString()}";
    }
  }

  void getTradablePairs() async {
    var response = await binanceFutures.exchangeInformation();
    if (response.isLeft) {
      tradablePairs = response.left;
    } else {
      var listSymbol = response.right.symbols.map((e) => e.symbol).toList();
      tradablePairs = "";
      for (var s in listSymbol) {
        tradablePairs += "$s ";
      }
    }
  }

  @override
  void dispose() {
    klineStreamSub.cancel();
    userdataStreamSub.cancel();
    super.dispose();
  }
}
```
