import 'package:bhutpurva_penal/features/manage_groups/edit_group/responsive/edit_group_desktop.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class EditGroup extends StatelessWidget {
  const EditGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayouts(desktop: const EditGroupDesktop());
  }
}
