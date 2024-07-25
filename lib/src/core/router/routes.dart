import 'package:flutter/material.dart';
import 'package:fudo_flutter/src/features/auth/presentation/ui/pages/login_page.dart';
import 'package:fudo_flutter/src/features/posts/presentation/ui/pages/post_detail_page.dart';
import 'package:fudo_flutter/src/home_page.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    // Auth
    TypedGoRoute<LoginRoute>(path: 'login'),

    // Posts
    TypedGoRoute<PostDetailRoute>(path: 'posts/:id'),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

// Posts

class PostDetailRoute extends GoRouteData {
  final int id;
  const PostDetailRoute(this.id);

  @override
  Widget build(BuildContext context, GoRouterState state) => PostDetailPage(id);
}

// Auth
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();
}
