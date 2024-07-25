import 'package:flutter/material.dart';
import 'package:fudo_flutter/src/core/router/routes.dart';
import 'package:fudo_flutter/src/features/auth/presentation/providers/is_authenticated_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

  final router = GoRouter(
    navigatorKey: routerKey,
    initialLocation: ref.watch(isAuthenticatedProvider)
        ? const HomeRoute().location
        : const LoginRoute().location,
    debugLogDiagnostics: true,
    routes: $appRoutes,
  );

  ref.onDispose(router.dispose); // always clean up after yourselves (:
  return router;
}
