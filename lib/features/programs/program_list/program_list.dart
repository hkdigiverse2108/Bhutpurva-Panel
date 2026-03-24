import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';
import 'responsive/program_list_desktop.dart';
import 'responsive/program_list_mobile.dart';

class ProgramList extends StatelessWidget {
  const ProgramList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SiteLayouts(
        desktop: const ProgramListDesktop(),
        mobile: const ProgramListMobile(),
      ),
    );
  }
}
