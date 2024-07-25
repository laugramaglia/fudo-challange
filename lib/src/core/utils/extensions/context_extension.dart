import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  successSnackBar([String? message]) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        backgroundColor: Theme.of(this).colorScheme.primary,
        content: Text(message ?? 'Success',
            style: Theme.of(this)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(this).colorScheme.onPrimary)),
      ));
  errorSnackBar(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        backgroundColor: Theme.of(this).colorScheme.error,
        content: Text(message,
            style: Theme.of(this)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(this).colorScheme.onError)),
      ));
}
