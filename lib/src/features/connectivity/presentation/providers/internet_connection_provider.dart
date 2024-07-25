import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'internet_connection_provider.g.dart';

@riverpod
class InternetConnection extends _$InternetConnection {
  @override
  Stream<ConnectivityResult> build() async* {
    final Connectivity connectivity = Connectivity();

    ref.keepAlive();
    yield* connectivity.onConnectivityChanged.asBroadcastStream();
  }
}
