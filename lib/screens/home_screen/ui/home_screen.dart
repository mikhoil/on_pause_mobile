import 'package:fl_query/fl_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../player_screen/ui/player_screen.dart';
import '../queries/use_user.dart';
import '../../practices_screen/ui/practices_screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Query(data: user) = useUser();

    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('lib/app/assets/fouling.png')))),
            user != null
                ? Positioned(
                    child: Transform.scale(
                        scale: .7 + user.progress / 100,
                        child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              constraints: BoxConstraints.expand(
                                  height: MediaQuery.of(context).size.width,
                                  width: MediaQuery.of(context).size.width),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(255, 247, 242, 1)),
                            ))))
                : CircularProgressIndicator(),
            Positioned(
                top: MediaQuery.of(context).size.height / 852 * 50,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 23, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color.fromRGBO(255, 251, 249, 0.85)),
                    child: Text(
                        "ДОБРОЕ УТРО, ${user != null ? user.username : ''}"
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'KyivType Sans',
                          color: Color.fromRGBO(61, 41, 26, 1),
                        )))),
            user != null
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(217, 210, 206, 1)),
                    child: Stack(
                      children: [
                        LinearProgressIndicator(
                          minHeight: 40,
                          backgroundColor:
                              const Color.fromRGBO(243, 228, 218, 1),
                          color: Color.fromRGBO(235, 137, 28, 1),
                          value: user.progress / 100,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text('${user.progress} / 100'))
                      ],
                      alignment: Alignment.centerLeft,
                    ))
                : CircularProgressIndicator(),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      alignment: Alignment.centerLeft,
                      fixedSize: MaterialStatePropertyAll(Size.fromRadius(61)),
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(246, 157, 58, 1))),
                  onPressed: () {
                    if (user != null &&
                        user.history.isNotEmpty &&
                        user.history.first.meditations.isNotEmpty) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlayerScreen(
                              meditation:
                                  user.history.first.meditations.last)));
                    }
                  },
                  child: Icon(Icons.play_arrow_rounded,
                      size: 75, color: Colors.white),
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PracticesScreen()));
                },
                style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                    shadowColor: const MaterialStatePropertyAll(Colors.white),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(27)),
                        side: BorderSide(
                            color: Colors.black.withOpacity(0.15))))),
                child: const Text(
                  "Выбрать медитацию",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              )
            ])
          ],
        ));
  }
}
