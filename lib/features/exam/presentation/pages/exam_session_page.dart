import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExamSessionPage extends StatelessWidget {
  const ExamSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),
    );
  }
}
