import 'package:bhutpurva_penal/shared/widgets/layouts/headers/header.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, this.body});

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Sidebar()),
          // Gap(20),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // header
                Header(),

                Expanded(child: body ?? const SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
