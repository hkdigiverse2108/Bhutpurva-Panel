import 'package:bhutpurva_penal/features/programs/program_details/responsive/program_detail_desktop.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class ProgramDetail extends StatelessWidget {
  const ProgramDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SiteLayouts(desktop: ProgramDetailDesktop()));
  }
}
