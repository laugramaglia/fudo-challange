// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internet_connection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$internetConnectionHash() =>
    r'e2e60dcd02fd1510370455dd9168eaa579ae2d20';

/// See also [InternetConnection].
@ProviderFor(InternetConnection)
final internetConnectionProvider = AutoDisposeStreamNotifierProvider<
    InternetConnection, ConnectivityResult>.internal(
  InternetConnection.new,
  name: r'internetConnectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$internetConnectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$InternetConnection = AutoDisposeStreamNotifier<ConnectivityResult>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
