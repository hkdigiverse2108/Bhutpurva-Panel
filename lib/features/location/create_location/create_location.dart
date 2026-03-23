import 'package:bhutpurva_penal/features/location/create_location/responsive/create_location_desktop.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class CreateLocation extends StatelessWidget {
  const CreateLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SiteLayouts(desktop: CreateLocationDesktop()));
  }
}
