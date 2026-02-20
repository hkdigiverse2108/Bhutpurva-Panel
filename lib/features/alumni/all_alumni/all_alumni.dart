import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

import 'responsive/all_alumni_desktop.dart';
import 'responsive/all_alumni_mobile.dart';

class AllAlumni extends StatelessWidget {
  const AllAlumni({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SiteLayouts(
        desktop: const AllAlumniDesktop(),
        mobile: const AllAlumniMobile(),
      ),
    );
  }
}
