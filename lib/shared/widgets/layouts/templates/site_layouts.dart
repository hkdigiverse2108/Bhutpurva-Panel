import 'package:bhutpurva_penal/shared/widgets/responsive/responsive_design.dart';
import 'package:bhutpurva_penal/shared/widgets/responsive/screens/desktop_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/responsive/screens/mobile_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/responsive/screens/tablet_layout.dart';
import 'package:flutter/material.dart';

class SiteLayouts extends StatelessWidget {
  const SiteLayouts({
    super.key,
    this.desktop,
    this.tablet,
    this.mobile,
    this.useLayout = true,
  });

  /// Widget for desktop layout
  final Widget? desktop;

  /// Widget for tablet layout
  final Widget? tablet;

  /// Widget for mobile layout
  final Widget? mobile;

  /// flag to use layout or not
  final bool useLayout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveDesign(
        desktop: useLayout
            ? DesktopLayout(body: desktop)
            : desktop ?? Container(),
        mobile: useLayout
            ? MobileLayout(body: mobile ?? desktop)
            : mobile ?? desktop ?? Container(),
        tablet: useLayout
            ? TabletLayout(body: tablet ?? desktop)
            : tablet ?? desktop ?? Container(),
      ),
    );
  }
}
