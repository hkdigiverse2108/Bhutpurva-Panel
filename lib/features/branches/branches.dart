import 'package:bhutpurva_penal/features/branches/responsive/branches_desktop.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class Branches extends StatelessWidget {
  const Branches({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SiteLayouts(desktop: BranchesDesktop()));
  }
}
