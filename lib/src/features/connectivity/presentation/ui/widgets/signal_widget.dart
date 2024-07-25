import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_flutter/src/core/utils/extensions/context_extension.dart';
import 'package:fudo_flutter/src/features/connectivity/presentation/providers/internet_connection_provider.dart';

class SignalWidget extends ConsumerWidget {
  const SignalWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(internetConnectionProvider);
    switch (state) {
      case AsyncData(:final value):
        if (value == ConnectivityResult.none) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.errorSnackBar('No internet connection');
          });
          return Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  child: Icon(
                    Icons.signal_wifi_off_rounded,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      case AsyncError(:final error):
        return Text(error.toString());
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
