import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

import 'responsive/anubhuti_desktop.dart';

class Anubhuti extends StatelessWidget {
  const Anubhuti({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SiteLayouts(desktop: const AnubhutiDesktop()));
  }
}
