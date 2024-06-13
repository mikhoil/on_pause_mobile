import 'package:fl_query/fl_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/ui/menu_btn.dart';
import '../../home_screen/queries/use_user.dart';

class PersonalDataScreen extends HookWidget {
  const PersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Query(data: user) = useUser();

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: AppBar()),
      body: Container(
          padding: EdgeInsets.only(left: 33, right: 33, top: 39, bottom: 65),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Row(
                        children: [
                          Icon(Icons.chevron_left),
                          Text(
                            'Настройки',
                            style: TextStyle(
                                color: Color.fromRGBO(61, 41, 26, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 42,
                    ),
                    Text(
                      'ЛИЧНЫЕ ДАННЫЕ',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 55,
                    ),
                    TextFormField(
                      // controller: controller,
                      initialValue: user != null ? user.username : '',
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9)),
                          label: Text('Имя')),
                    ),
                    SizedBox(
                      height: 29,
                    ),
                    MenuButton(
                        text: 'Изменить пароль',
                        onPressed: () {},
                        leftIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: Color.fromRGBO(61, 41, 26, 1),
                        ),
                        rightIcon: SvgPicture.asset(
                            'lib/app/assets/top_right_arrow.svg')),
                    SizedBox(
                      height: 12,
                    ),
                    MenuButton(
                        text: 'Изменить почту',
                        onPressed: () {},
                        leftIcon: Icon(
                          Icons.mail_outline_outlined,
                          color: Color.fromRGBO(61, 41, 26, 1),
                        ),
                        rightIcon: SvgPicture.asset(
                            'lib/app/assets/top_right_arrow.svg')),
                  ],
                ),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 44, vertical: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromRGBO(148, 115, 92, 0.06)),
                      child: Text('Удалить аккаунт'),
                    ))
              ])),
    );
  }
}
