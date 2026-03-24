import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

import 'responsive/create_program_desktop.dart';
import 'responsive/create_program_mobile.dart';

class CreateProgram extends StatelessWidget {
  const CreateProgram({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayouts(
      desktop: const CreateProgramDesktop(),
      mobile: const CreateProgramMobile(),
    );
  }
}
