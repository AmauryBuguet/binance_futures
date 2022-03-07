/// Unofficial Dart wrapper for Binance SPOT API (REST endpoints + Websockets).
library binance_futures;

export 'src/binance_futures_api.dart';

export 'src/common/classes.dart';
export 'src/common/enums.dart';

export 'src/rest/classes.dart';
export 'src/rest/enums.dart';
export 'src/rest/endpoints/market_data.dart';
export 'src/rest/endpoints/user_data.dart';
export 'src/rest/endpoints/account_trade.dart';

export 'src/websocket/classes.dart';
export 'src/websocket/enums.dart';
export 'src/websocket/market_stream.dart';
export 'src/websocket/user_data_stream.dart';
