import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/features/settings/controllers/settings_controller.dart';
import 'package:bhutpurva_penal/features/settings/widgets/account_tab.dart';
import 'package:bhutpurva_penal/features/settings/widgets/app_tab.dart';
import 'package:bhutpurva_penal/features/settings/widgets/notifications_tab.dart';
import 'package:bhutpurva_penal/features/settings/widgets/other_tab.dart';
import 'package:bhutpurva_penal/features/settings/widgets/policy_tab.dart';
import 'package:bhutpurva_penal/features/settings/widgets/security_tab.dart';
import 'package:bhutpurva_penal/features/settings/widgets/tab_card.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_from_page_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SettingsDesktop extends StatelessWidget {
  const SettingsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return AdminFormPageLayout(
      header: BreadcrumbWithHeading(
        heading: 'Settings',
        breadcrumbsItems: [BreadcrumbItem(title: 'Settings')],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...controller.tabs.map(
                    (e) => TabCard(
                      text: e,
                      onTap: () => controller.changeTab(e),
                      isSelected: controller.selectedTab.value == e,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(SizeConst.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => switch (controller.selectedTab.value) {
                'Account' => AccountTab(),
                'Security' => SecurityTab(),
                'Notification' => NotificationsTab(),
                'App' => AppTab(),
                'policy' => PolicyTab(),
                'other' => OtherTab(),
                String() => throw UnimplementedError(),
              },
            ),
          ),
        ],
      ),
    );
  }
}
