import 'package:flutter/material.dart';
import '../../../../../features/sign_form/ui/sign_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0), child: AppBar()),
        body: Padding(
            padding: EdgeInsets.only(left: 21, right: 21, top: 99, bottom: 34),
            child: SignForm()));
  }
}
