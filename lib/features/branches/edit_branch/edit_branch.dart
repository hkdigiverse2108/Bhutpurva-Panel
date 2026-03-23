import 'package:bhutpurva_penal/features/branches/edit_branch/responsive/edit_branch_desktop.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class EditBranch extends StatelessWidget {
  const EditBranch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SiteLayouts(desktop: EditBranchDesktop()));
  }
}
