import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/features/auth/login/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginMobile extends StatelessWidget {
  const LoginMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SizeConst.defaultSpace),
        child: LoginForm(),
      ),
    );
  }
}
