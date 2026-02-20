import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/core/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminFormPageLayout extends StatelessWidget {
  final Widget header;
  final Widget body;
  final Widget? footerBar;

  const AdminFormPageLayout({
    super.key,
    required this.header,
    required this.body,
    this.footerBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: DeviceUtility.isMobileScreen(context)
            ? const EdgeInsets.all(SizeConst.mobileDefaultSpace)
            : const EdgeInsets.all(SizeConst.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [header, Gap(SizeConst.spaceBtwSections), body],
        ),
      ),
      bottomNavigationBar: footerBar,
    );
  }
}
