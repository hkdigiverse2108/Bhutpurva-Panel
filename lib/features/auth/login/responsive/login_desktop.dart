import 'package:bhutpurva_penal/features/auth/login/widgets/login_form.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/login_template.dart';
import 'package:flutter/material.dart';

class LoginDesktop extends StatelessWidget {
  const LoginDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginTemplate(child: const LoginForm());
  }
}
