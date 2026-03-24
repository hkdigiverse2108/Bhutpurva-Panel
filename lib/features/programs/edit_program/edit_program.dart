import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

import 'responsive/edit_program_desktop.dart';
import 'responsive/edit_program_mobile.dart';

class EditProgram extends StatelessWidget {
  const EditProgram({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayouts(
      desktop: const EditProgramDesktop(),
      mobile: const EditProgramMobile(),
    );
  }
}
