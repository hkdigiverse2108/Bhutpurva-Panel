import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/features/calender/controllers/calender_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CalenderDesktop extends StatelessWidget {
  const CalenderDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CalenderController.instance;
    return AdminTablePageLayout(
      header: BreadcrumbWithHeading(
        heading: 'Calender',
        breadcrumbsItems: [BreadcrumbItem(title: 'Calender')],
      ),
      toolbar: AdminTableToolbar(
        actions: [
          TableActionButton(
            onTap: () {},
            label: 'add Next Calender',
            icon: Icons.add,
            color: ColorConst.primary,
          ),
          const Gap(10),
          TableActionButton(
            onTap: () {},
            label: 'Update Calender',
            icon: Icons.calendar_month,
            color: ColorConst.primary,
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.chevron_left)),
              const Gap(10),
              Obx(
                () => Text('${controller.selected.value} ${controller.year}'),
              ),
              const Gap(10),
              IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right)),
            ],
          ),
          const Gap(10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ColorConst.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ColorConst.primary.withValues(alpha: 0.2),
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConst.softGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
