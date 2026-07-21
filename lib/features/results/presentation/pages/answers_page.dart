import 'package:exams/core/routing/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnswersPage extends StatelessWidget {
  const AnswersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Answers'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.go(RoutePaths.results),
        ),
      ),
    );
  }
}
