import 'package:fl_query/fl_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import '../../../shared/ui/close.dart';
import '../../../shared/utils/getTokens.dart';
import '../../../widgets/choose_meditation/ui/choose_meditation.dart';
import '../../../widgets/practices_list/ui/practices_list.dart';
import '../queries/use_practices.dart';

class PracticesScreen extends HookWidget {
  const PracticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = useFuture(getTokens(), initialData: null);

    final Query(data: practices) = usePractices(tokens.data?.accessToken ?? "");

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0), child: AppBar()),
        body: practices == null
            ? Text("loading...")
            : Solid(
                providers: [
                  Provider<Signal<int>>(create: () => Signal(0), id: 0),
                  Provider<Signal<int>>(create: () => Signal(0), id: 1),
                ],
                builder: (context) {
                  final practiceIdx = context.get<Signal<int>>(0);

                  return Stack(alignment: Alignment.bottomCenter, children: [
                    PracticesList(
                      practices: practices,
                    ),
                    ChooseMeditation(
                      practice: practices[practiceIdx.value],
                    ),
                    const Close(),
                  ]);
                },
              ));
  }
}
