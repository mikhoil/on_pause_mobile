import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../entities/affirmation/ui/today_affirmation.dart';

class AffirmationScreen extends HookWidget {
  const AffirmationScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(),
      ),
      body: const TodayAffirmation(),
    );
  }
}
