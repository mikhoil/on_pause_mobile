import 'package:flutter/material.dart';

class HiddenAppBar extends StatelessWidget {
  const HiddenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(0), child: AppBar());
  }
}
