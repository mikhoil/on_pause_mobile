import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onpause/shared/ui/close.dart';
import 'package:onpause/widgets/choose_meditation/ui/choose_meditation.dart';
import 'package:onpause/widgets/practices_list/ui/practices_list.dart';

class PracticesScreen extends HookWidget {
  const PracticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0), child: AppBar()),
        body: const Stack(alignment: Alignment.bottomCenter, children: [
          PracticesList(),
          ChooseMeditation(),
          Close(),
        ]));
  }
}
