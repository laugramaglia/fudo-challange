import 'package:flutter/material.dart';

mixin LoadingOverlayMixin {
  OverlayEntry initOverlay() => OverlayEntry(
        builder: (context) => Container(
          color: Theme.of(context).colorScheme.primary.withOpacity(.1),
          child: Center(
            child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const CircularProgressIndicator.adaptive()),
          ),
        ),
      );
}
