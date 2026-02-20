import 'package:bhutpurva_penal/features/life_light/responsive/life_light_desktop.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class LifeLight extends StatelessWidget {
  const LifeLight({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SiteLayouts(desktop: LifeLightDesktop()));
  }
}
