import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

    Future<void> hasToken() async {
      if (selectedIndex.value == 2) (await prefs).remove("token");
      if (!(await prefs).containsKey("token")) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    }

    useEffect(() {
      hasToken();
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
