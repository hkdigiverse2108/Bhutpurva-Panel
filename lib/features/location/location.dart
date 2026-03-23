import 'package:bhutpurva_penal/features/location/location_list/responsive/location_desktop.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SiteLayouts(desktop: LocationDesktop()));
  }
}
