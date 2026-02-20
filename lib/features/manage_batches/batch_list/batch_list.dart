import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

import 'responsive/batch_list_desktop.dart';
import 'responsive/batch_list_mobile.dart';

class BatchList extends StatelessWidget {
  const BatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SiteLayouts(
        desktop: const BatchListDesktop(),
        mobile: const BatchListMobile(),
      ),
    );
  }
}
