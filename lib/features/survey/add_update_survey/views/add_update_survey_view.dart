import 'package:bhutpurva_penal/features/survey/add_update_survey/responsive/add_update_survey_desktop.dart';
import 'package:bhutpurva_penal/features/survey/add_update_survey/responsive/add_update_survey_mobile.dart';
import 'package:bhutpurva_penal/features/survey/add_update_survey/responsive/add_update_survey_tablet.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class AddUpdateSurveyView extends StatelessWidget {
  const AddUpdateSurveyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayouts(
      mobile: AddUpdateSurveyMobile(),
      tablet: AddUpdateSurveyTablet(),
      desktop: AddUpdateSurveyDesktop(),
    );
  }
}
