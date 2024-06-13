import 'package:fl_query/fl_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/history/ui/history.dart';
import '../../settings_screen/ui/settings_screen.dart';
import '../../../screens/home_screen/queries/use_user.dart';
import '../../../widgets/statistics/ui/statistics.dart';

class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Query(data: user) = useUser();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0), child: AppBar()),
        body: Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(255, 242, 233, 1),
                Color.fromRGBO(246, 194, 157, 1),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 852 * 89),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Color.fromRGBO(233, 218, 209, .5)),
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Text(user != null ? user.username : '',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Color.fromRGBO(61, 41, 26, 1))))),
                  SizedBox(height: 11),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60)),
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                            user != null && user.hasSubscribe
                                ? "ПРЕМИУМ"
                                : 'НЕТ ПОДПИСКИ',
                            style: TextStyle(
                                color: Color.fromRGBO(44, 49, 53, 1),
                                fontSize: 15))),
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height /
                      852 *
                      (852 - 96) /
                      852 *
                      535,
                  padding: EdgeInsets.only(top: 10, right: 8, left: 8),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 247, 242, 1),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.elliptical(2, 2))),
                  child: user != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Statistics(
                                dailyStrick: user.dailyStrick,
                                sessionsCount: user.sessionCount,
                                totalTime: user.totalTime,
                              ),
                              SizedBox(height: 13),
                              History(history: user.history),
                            ])
                      : CircularProgressIndicator(),
                )),
            Positioned(
                top: 25,
                right: 16,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SettingsScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.white,
                        fixedSize: Size.fromRadius(26)),
                    child: SvgPicture.asset(
                      'lib/app/assets/settings.svg',
                      height: 30,
                    ))),
          ],
        ));
  }
}
