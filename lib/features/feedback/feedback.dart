import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

import 'responsive/feedback_desktop.dart';

class Feedback extends StatelessWidget {
  const Feedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SiteLayouts(desktop: const FeedbackDesktop()));
  }
}
