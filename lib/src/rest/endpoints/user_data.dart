import 'package:binance_futures/src/binance_futures_api.dart';
import 'package:binance_futures/src/rest/enums.dart';
import 'package:either_dart/either.dart';

/// User Data Endpoints for Binance Spot API
extension UserDataEndpoints on BinanceFutures {
  /// Start a new user data stream. The stream will close after 60 minutes unless a keepalive is sent.
  ///
  /// If the account has an active listenKey, that listenKey will be returned and its validity will be extended for 60 minutes.
  Future<Either<String, String>> createListenKey() {
    return sendRequest(
      path: 'fapi/v1/listenKey',
      type: RequestType.POST,
      keyRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right['listenKey']));
  }

  /// Keepalive a user data stream to prevent a time out.
  ///
  /// User data streams will close after 60 minutes. It's recommended to send a ping about every 60 minutes.
  Future<Either<String, bool>> pingListenKey() {
    return sendRequest(
      path: 'fapi/v1/listenKey',
      type: RequestType.PUT,
      keyRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : const Right(true));
  }

  /// Close out a user data stream.
  Future<Either<String, bool>> deleteListenKey() {
    return sendRequest(
      path: 'fapi/v1/listenKey',
      type: RequestType.DELETE,
      keyRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : const Right(true));
  }
}
