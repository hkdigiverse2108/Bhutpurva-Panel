import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

import 'responsive/group_details_desktop.dart';

class GroupDetails extends StatelessWidget {
  const GroupDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SiteLayouts(desktop: const GroupDetailsDesktop()));
  }
}
