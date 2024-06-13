import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../login_screen/ui/login_screen.dart';
import '../../notifications_screen/ui/notifications_screen.dart';
import '../../offer_screen/ui/offer_screen.dart';
import '../../personal_data_screen/ui/personal_data_screen.dart';
import '../queries/use_logout.dart';
import '../../subscription_screen/ui/subscription_screen.dart';
import '../../../shared/ui/menu_btn.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logout = useLogout(() => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen())));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(),
      ),
      body: Stack(children: [
        Container(
          padding: EdgeInsets.only(left: 33, right: 33, top: 99, bottom: 54),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Text(
                  'НАСТРОЙКИ ПРИЛОЖЕНИЯ',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                ),
                SizedBox(height: 52),
                Column(
                  children: [
                    MenuButton(
                      text: 'Профиль',
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => PersonalDataScreen())),
                      leftIcon: SvgPicture.asset(
                        'lib/app/assets/profile.svg',
                        colorFilter: ColorFilter.mode(
                            Color.fromRGBO(61, 41, 26, 1), BlendMode.srcATop),
                        height: 19,
                      ),
                      rightIcon: Icon(Icons.chevron_right_outlined),
                    ),
                    const SizedBox(height: 12),
                    MenuButton(
                      text: 'Уведомления',
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationsScreen())),
                      leftIcon:
                          SvgPicture.asset('lib/app/assets/notifications.svg'),
                      rightIcon: Icon(Icons.chevron_right_outlined),
                    ),
                    const SizedBox(height: 12),
                    MenuButton(
                      text: 'Подписка',
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SubscriptionScreen())),
                      leftIcon:
                          SvgPicture.asset('lib/app/assets/subscription.svg'),
                      rightIcon: Icon(Icons.chevron_right_outlined),
                    ),
                    const SizedBox(height: 12),
                    MenuButton(
                      text: 'Юридическая информация',
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const OfferScreen())),
                      leftIcon: Icon(
                        Icons.text_snippet_outlined,
                        color: Color.fromRGBO(61, 41, 26, 1),
                      ),
                      rightIcon: Icon(Icons.chevron_right_outlined),
                    ),
                  ],
                ),
              ]),
              GestureDetector(
                  onTap: () {
                    logout.mutate(());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 17),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(148, 115, 92, 0.06),
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(
                      'Выйти из аккаунта',
                      style: TextStyle(
                          color: Color.fromRGBO(61, 41, 26, .6), fontSize: 15),
                    ),
                  )),
            ],
          ),
        ),
        Positioned(
            right: 33,
            top: 29,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  foregroundColor: Color.fromRGBO(123, 102, 87, .27),
                  backgroundColor: Color.fromRGBO(148, 115, 92, .06),
                  fixedSize: Size.fromRadius(21)),
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close),
            )),
      ]),
    );
  }
}
