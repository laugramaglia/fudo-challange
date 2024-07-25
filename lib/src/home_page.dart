import 'package:flutter/material.dart';
import 'package:fudo_flutter/src/features/posts/presentation/ui/pages/posts_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(body: PostsListPage());
}
