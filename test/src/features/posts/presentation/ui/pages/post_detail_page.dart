import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final int id;
  const PostDetailPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Center(
        child: Text("ID: $id"),
      ),
    );
  }
}
