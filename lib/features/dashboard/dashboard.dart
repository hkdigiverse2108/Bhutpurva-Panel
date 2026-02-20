import 'package:bhutpurva_penal/features/dashboard/responsive/dashboard_desktop.dart';
import 'package:bhutpurva_penal/features/dashboard/responsive/dashboard_mobile.dart';
import 'package:bhutpurva_penal/features/dashboard/responsive/dashboard_tablet.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayouts(
      desktop: const DashboardDesktop(),
      tablet: const DashboardTablet(),
      mobile: const DashboardMobile(),
    );
  }
}
