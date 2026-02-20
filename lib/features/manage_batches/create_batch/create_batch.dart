import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

import 'responsive/create_batch_desktop.dart';

class CreateBatch extends StatelessWidget {
  const CreateBatch({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayouts(desktop: CreateBatchDesktop());
  }
}
