import 'package:bhutpurva_penal/features/manage_batches/edit_batches/responsive/edit_batches_desktop.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class EditBatch extends StatelessWidget {
  const EditBatch({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayouts(desktop: EditBatchDesktop());
  }
}
