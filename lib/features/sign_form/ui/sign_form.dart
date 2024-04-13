import 'package:dio/dio.dart';
import 'package:fl_query/fl_query.dart';
import 'package:fl_query_hooks/fl_query_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onpause/app/layouts/main_layout.dart';
import 'package:onpause/features/sign_form/api/register.dart';
import 'package:onpause/features/sign_form/queries/useLoginMutation.dart';
import 'package:onpause/features/sign_form/queries/useRegisterMutation.dart';
import 'package:onpause/screens/login_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../screens/register_screen.dart';
import '../../../shared/ui/bbb.dart';
import '../../oauth_button/ui/index.dart';
import '../../other_sign_link/ui/index.dart';
import '../../sign_form_field/ui/index.dart';
import '../api/login.dart';

enum Sign { login, register }

class SignForm extends HookWidget {
  SignForm({super.key, this.signType = Sign.register});

  final Sign signType;

  @override
  Widget build(BuildContext context) {
    final form = FormGroup({
      if (signType == Sign.register) "username": FormControl<String>(),
      "email": FormControl<String>(),
      "password": FormControl<String>(),
    });

    Future<void> setToken(String token) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", token);
      print(prefs.get("token"));
    }

    final loginMutation =
        useLoginMutation((data, other) => setToken(data.token));
    final registerMutation =
        useRegisterMutation((data, other) => setToken(data.token));

    Future<void> hasToken() async {
      final prefs = await SharedPreferences.getInstance();
      print(prefs.get("token"));
      if (prefs.containsKey("token")) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const MainLayout()));
      }
    }

    useEffect(() {
      hasToken();
      return null;
    }, [loginMutation.data?.token, registerMutation.data?.token]);

    return ReactiveFormBuilder(
        form: () => form,
        builder: (context, form, child) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    SvgPicture.asset("lib/app/assets/logo.svg"),
                    const SizedBox(height: 51),
                    SignTextField(
                      name: "email",
                      label: "Почта",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    signType == Sign.register
                        ? Column(children: [
                            SignTextField(
                              name: "username",
                              label: "Ваше имя",
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ])
                        : Container(),
                    SignTextField(
                      name: "password",
                      label: "Пароль",
                      obscureText: true,
                    ),
                    const SizedBox(height: 61),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OAuthButton(iconPath: 'lib/app/assets/vk_auth.png'),
                          SizedBox(width: 24),
                          OAuthButton(
                              iconPath: 'lib/app/assets/google_auth.png'),
                          SizedBox(width: 24),
                          OAuthButton(iconPath: 'lib/app/assets/fb_auth.svg'),
                        ]),
                  ]),
                  Column(
                    children: [
                      OtherSignLink(
                          label: signType == Sign.login
                              ? "Создать новый аккаунт"
                              : "Вернуться ко входу",
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => signType == Sign.login
                                    ? const RegisterScreen()
                                    : const LoginScreen()));
                          }),
                      const SizedBox(height: 15),
                      ReactiveFormConsumer(
                          builder: (context, form, child) => BBB(
                              label: signType == Sign.login
                                  ? "Войти"
                                  : "Создать аккаунт",
                              onPressed: () {
                                if (form.valid) {
                                  print(form.value);
                                  if (signType == Sign.login) {
                                    loginMutation.mutate(
                                        LoginRequest.fromJson(form.value));
                                  } else {
                                    registerMutation.mutate(
                                        RegisterRequest.fromJson(form.value));
                                  }
                                }
                              }))
                    ],
                  )
                ]));
  }
}