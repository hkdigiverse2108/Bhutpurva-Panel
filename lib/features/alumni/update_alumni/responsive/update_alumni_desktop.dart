import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/features/alumni/update_alumni/controllers/update_alumni_controller.dart';
import 'package:bhutpurva_penal/features/alumni/update_alumni/widgets/address_details.dart';
import 'package:bhutpurva_penal/features/alumni/update_alumni/widgets/major_details.dart';
import 'package:bhutpurva_penal/features/alumni/update_alumni/widgets/primary_details.dart';
import 'package:bhutpurva_penal/features/alumni/update_alumni/widgets/secondary_details.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/form_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_from_page_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class UpdateAlumniDesktop extends StatelessWidget {
  const UpdateAlumniDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UpdateAlumniController.instance;
    return Scaffold(
      body: AdminFormPageLayout(
        header: BreadcrumbWithHeading(
          heading: 'Update Profile',
          returnToPreviousScreen: true,
          breadcrumbsItems: [
            BreadcrumbItem(title: 'Alumni', route: AppPages.allAlumni),
            BreadcrumbItem(title: 'Update Alumni'),
          ],
        ),
        body: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PrimaryDetails(controller: controller),
              const Gap(16),
              MajorDetails(controller: controller),
              const Gap(16),
              AddressDetails(),
              const Gap(16),
              SecondaryDetails(),
              const Gap(16),
            ],
          ),
        ),
        footerBar: Container(
          padding: EdgeInsets.all(SizeConst.defaultSpace),
          width: 550,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile =
                  constraints.maxWidth < SizeConst.mobileScreenSize;

              if (isMobile) {
                return Column(
                  children: [
                    AdminFormButton(
                      label: 'Cancel',
                      variant: AdminButtonVariant.secondary,
                      onPressed: () => Get.back(),
                    ),
                    const SizedBox(height: 12),
                    AdminFormButton(
                      label: 'Update Profile',
                      isLoading: controller.isLoading.value,
                      onPressed: () {},
                    ),
                  ],
                );
              }

              // Desktop / Tablet
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 150,
                    child: AdminFormButton(
                      label: 'Cancel',
                      variant: AdminButtonVariant.secondary,
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 150,
                    child: AdminFormButton(
                      label: 'Update Profile',
                      isLoading: controller.isLoading.value,
                      onPressed: () {},
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
