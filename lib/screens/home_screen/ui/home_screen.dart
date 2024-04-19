import 'package:fl_query/fl_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/utils/getToken.dart';
import '../queries/use_user.dart';
import '../../practices_screen/ui/practices_screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final snapshot = useFuture(getToken(), initialData: null);

    final Query(data: user) = useUser(snapshot.data ?? "");

    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(),
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('lib/app/assets/fouling.png'))),
            child: Padding(
                padding: const EdgeInsets.only(top: 21, bottom: 42),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 23, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: const Color.fromRGBO(52, 49, 47, 0.7)),
                            child: Text(
                                "ДОБРОЕ УТРО, ${user != null ? user.username : ''}"
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                ))),
                        const SizedBox(height: 8),
                        ElevatedButton(
                            onPressed: () {},
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromRGBO(52, 49, 47, 0.7))),
                            child: const Text(
                              "Мои планы",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ))
                      ]),
                      Transform.scale(
                          scale: 1,
                          child: Container(
                              constraints: const BoxConstraints.expand(
                                  height: 452, width: 452),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: const ButtonStyle(
                                            fixedSize: MaterialStatePropertyAll(
                                                Size.fromRadius(61)),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color.fromRGBO(
                                                        0, 0, 0, 0.01))),
                                        onPressed: () {
                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             const PlayerScreen()));
                                        },
                                        child: SvgPicture.asset(
                                            'lib/app/assets/play.svg'),
                                      ),
                                    ),
                                    const SizedBox(height: 28),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PracticesScreen()));
                                      },
                                      style: ButtonStyle(
                                          padding: const MaterialStatePropertyAll(
                                              EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 10)),
                                          shadowColor: const MaterialStatePropertyAll(
                                              Colors.white),
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.white),
                                          shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(27)),
                                                  side: BorderSide(
                                                      color: Colors.black
                                                          .withOpacity(0.15))))),
                                      child: const Text(
                                        "Выбрать медитацию",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ]))),
                      Stack(children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 21),
                            child: LinearProgressIndicator(
                              minHeight: 2,
                              borderRadius: BorderRadius.circular(10),
                              backgroundColor:
                                  const Color.fromRGBO(108, 124, 137, 1),
                              color: Colors.white,
                              value: .25,
                            )),
                        Center(
                            child: Container(
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(33, 42, 50, 1),
                                    borderRadius: BorderRadius.circular(14),
                                    shape: BoxShape.rectangle),
                                child: const Text(
                                  "25",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )))
                      ])
                    ]))));
  }
}
