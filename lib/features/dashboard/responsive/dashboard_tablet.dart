import 'package:bhutpurva_penal/features/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';

class DashboardTablet extends StatelessWidget {
  const DashboardTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
