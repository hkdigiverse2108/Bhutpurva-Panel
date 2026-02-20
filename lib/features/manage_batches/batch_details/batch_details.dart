import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

import 'responsive/batch_details_desktop.dart';

class BatchDetails extends StatelessWidget {
  const BatchDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SiteLayouts(desktop: BatchDetailsDesktop()));
  }
}
