import 'package:bhutpurva_penal/features/auth/login/responsive/login_desktop.dart';
import 'package:bhutpurva_penal/features/auth/login/responsive/login_mobile.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SiteLayouts(
        useLayout: false,
        desktop: const LoginDesktop(),
        mobile: const LoginMobile(),
      ),
    );
  }
}
