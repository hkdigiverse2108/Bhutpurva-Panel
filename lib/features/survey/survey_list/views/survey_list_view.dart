import 'package:flutter/material.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:bhutpurva_penal/features/survey/survey_list/responsive/survey_list_desktop.dart';
import 'package:bhutpurva_penal/features/survey/survey_list/responsive/survey_list_mobile.dart';
import 'package:bhutpurva_penal/features/survey/survey_list/responsive/survey_list_tablet.dart';

class SurveyListView extends StatelessWidget {
  const SurveyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayouts(
      mobile: SurveyListMobile(),
      tablet: SurveyListTablet(),
      desktop: SurveyListDesktop(),
    );
  }
}
