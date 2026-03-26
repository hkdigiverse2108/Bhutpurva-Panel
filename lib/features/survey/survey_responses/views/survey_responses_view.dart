import 'package:bhutpurva_penal/features/survey/survey_responses/responsive/survey_responses_desktop.dart';
import 'package:bhutpurva_penal/features/survey/survey_responses/responsive/survey_responses_mobile.dart';
import 'package:bhutpurva_penal/features/survey/survey_responses/responsive/survey_responses_tablet.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class SurveyResponsesView extends StatelessWidget {
  const SurveyResponsesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayouts(
      mobile: SurveyResponsesMobile(),
      tablet: SurveyResponsesTablet(),
      desktop: SurveyResponsesDesktop(),
    );
  }
}
