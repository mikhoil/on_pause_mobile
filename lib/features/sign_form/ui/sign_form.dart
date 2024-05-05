import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/layouts/main_layout.dart';
import '../../../shared/api/models/login_request.dart';
import '../../../shared/api/models/register_request.dart';
import '../../../shared/utils/setTokens.dart';
import '../queries/useLoginMutation.dart';
import '../queries/useRegisterMutation.dart';
import '../../../screens/login_screen.dart';
import '../../../screens/register_screen.dart';
import '../../../shared/ui/bbb.dart';
import '../../oauth_button/ui/index.dart';
import '../../other_sign_link/ui/index.dart';
import '../../sign_form_field/ui/sign_form_field.dart';

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

    final loginMutation = useLoginMutation((data, other) => setTokens(data));

    final registerMutation =
        useRegisterMutation((data, other) => setTokens(data));

    final prefs = SharedPreferences.getInstance();

    useEffect(() {
      prefs.then((value) {
        final accessToken = value.getString('accessToken');
        if (accessToken != null && accessToken != '') {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const MainLayout()));
        }
      });

      return null;
    }, [loginMutation.data, registerMutation.data]);

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
