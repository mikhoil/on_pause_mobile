import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onpause/shared/utils/get_tokens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/affirmations_screen/ui/affirmations_screen.dart';
import '../../screens/profile_screen/ui/profile_screen.dart';
import '../../screens/home_screen/ui/home_screen.dart';
import '../../screens/login_screen/ui/login_screen.dart';

class MainLayout extends HookWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    final widgetOptions = <Widget>[
      HomeScreen(),
      AffirmationScreen(),
      ProfileScreen(),
    ];

    final prefs = SharedPreferences.getInstance();
    final results = useMemoized(getTokens, []);
    final snapshot = useFuture(results, initialData: null);

    useEffect(() {
      prefs.then((value) {
        print("accessToken ${value.getString('accessToken')}");
      });
    }, []);

    return snapshot.data != null
        ? Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(0), child: AppBar()),
            body: snapshot.data?.accessToken != ''
                ? widgetOptions[selectedIndex.value]
                : const LoginScreen(),
            bottomNavigationBar: snapshot.data?.accessToken != ''
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 852 * 96,
                    child: BottomNavigationBar(
                      backgroundColor: Color.fromRGBO(255, 247, 242, 1),
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      items: [
                        BottomNavigationBarItem(
                            activeIcon: SvgPicture.asset(
                                'lib/app/assets/active_player.svg'),
                            icon: SvgPicture.asset('lib/app/assets/player.svg'),
                            label: ""),
                        BottomNavigationBarItem(
                            activeIcon: SvgPicture.asset(
                                'lib/app/assets/active_affirmations.svg'),
                            icon: SvgPicture.asset(
                                'lib/app/assets/affirmations.svg'),
                            label: ""),
                        BottomNavigationBarItem(
                            activeIcon: SvgPicture.asset(
                                'lib/app/assets/active_profile.svg'),
                            icon:
                                SvgPicture.asset('lib/app/assets/profile.svg'),
                            label: ""),
                      ],
                      currentIndex: selectedIndex.value,
                      onTap: (index) => selectedIndex.value = index,
                    ),
                  )
                : SizedBox(
                    height: 0,
                  ))
        : CircularProgressIndicator();
  }
}
