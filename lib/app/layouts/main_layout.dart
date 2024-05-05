import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onpause/features/sign_form/api/login.dart';
import 'package:onpause/shared/utils/refreshTokens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/utils/clearPrefs.dart';
import '../../shared/utils/getTokens.dart';

import '../../screens/home_screen/ui/home_screen.dart';
import '../../screens/login_screen.dart';

class MainLayout extends HookWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    const widgetOptions = <Widget>[
      HomeScreen(),
      Text('b'),
      Text('c'),
    ];

    final prefs = SharedPreferences.getInstance();

    useEffect(() {
      prefs.then((value) {
        if (selectedIndex.value == 2) {
          withRefreshTokens(() => Dio(BaseOptions(
                  baseUrl: 'http://10.0.2.2:3000',
                  headers: {
                    "Authorization": "Bearer ${value.getString('accessToken')}"
                  })).get('/auth/logout'));
          clearPrefs();
        }
        prefs.then((value) {
          if (!value.containsKey('accessToken')) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          }
        });
      });
      return null;
    }, [selectedIndex.value]);

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0), child: AppBar()),
        body: widgetOptions[selectedIndex.value],
        bottomNavigationBar: SizedBox(
          height: 96,
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  activeIcon:
                      SvgPicture.asset('lib/app/assets/active_player.svg'),
                  icon: SvgPicture.asset('lib/app/assets/player.svg'),
                  label: ""),
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                      'lib/app/assets/active_affirmations.svg'),
                  icon: SvgPicture.asset('lib/app/assets/affirmations.svg'),
                  label: ""),
              BottomNavigationBarItem(
                  activeIcon:
                      SvgPicture.asset('lib/app/assets/active_profile.svg'),
                  icon: SvgPicture.asset('lib/app/assets/profile.svg'),
                  label: ""),
            ],
            currentIndex: selectedIndex.value,
            onTap: (index) => selectedIndex.value = index,
          ),
        ));
  }
}
