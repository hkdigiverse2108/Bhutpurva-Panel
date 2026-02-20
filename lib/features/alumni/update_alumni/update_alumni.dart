import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

import 'responsive/update_alumni_desktop.dart';

class UpdateAlumni extends StatelessWidget {
  const UpdateAlumni({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SiteLayouts(desktop: UpdateAlumniDesktop()));
  }
}
