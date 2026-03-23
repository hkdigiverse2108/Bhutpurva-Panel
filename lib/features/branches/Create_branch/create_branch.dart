import 'package:bhutpurva_penal/features/branches/Create_branch/responsive/create_branch_desktop.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class CreateBranch extends StatelessWidget {
  const CreateBranch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SiteLayouts(desktop: CreateBranchDesktop()));
  }
}
