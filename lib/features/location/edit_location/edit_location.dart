import 'package:bhutpurva_penal/features/location/edit_location/responsive/edit_location_desktop.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class EditLocation extends StatelessWidget {
  const EditLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SiteLayouts(desktop: EditLocationDesktop()));
  }
}
