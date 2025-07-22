import 'package:flutter/material.dart';
import 'package:projectexp/pages/home/widgets/topbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          'Budget App',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const DynamicHeaderWidget(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}