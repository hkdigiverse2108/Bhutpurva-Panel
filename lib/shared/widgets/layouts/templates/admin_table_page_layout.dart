import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/core/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminTablePageLayout extends StatelessWidget {
  final Widget header;
  final Widget body;
  final Widget? toolbar;
  final Widget? filter;
  final bool showFilter;
  final double? tableHeight;

  const AdminTablePageLayout({
    super.key,
    required this.header,
    required this.body,
    this.toolbar,
    this.filter,
    this.showFilter = false,
    this.tableHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: DeviceUtility.isMobileScreen(context)
          ? const EdgeInsets.all(SizeConst.mobileDefaultSpace)
          : const EdgeInsets.all(SizeConst.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,

          if (toolbar != null) ...[
            const Gap(SizeConst.spaceBtwSections),
            toolbar!,
          ],

          if (filter != null && showFilter) ...[
            const Gap(SizeConst.spaceBtwItems),
            filter!,
          ],

          Gap(
            (toolbar == null)
                ? SizeConst.spaceBtwSections
                : SizeConst.spaceBtwItems,
          ),

          SizedBox(height: tableHeight ?? SizeConst.tableHeight, child: body),
        ],
      ),
    );
  }
}
