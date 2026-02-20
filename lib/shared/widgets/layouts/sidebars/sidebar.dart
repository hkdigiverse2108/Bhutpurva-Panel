import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/constants/image_const.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/core/helpers/helpers.dart';
import 'package:bhutpurva_penal/shared/widgets/images/rounded_image.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/sidebars/controllers/sidebar_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/sidebars/menu/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SidebarController());
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        decoration: BoxDecoration(
          color: HelperFunctions.isDarkMode(context)
              ? ColorConst.dark
              : ColorConst.white,
          border: Border(
            right: BorderSide(
              color: ColorConst.grey.withOpacity(0.3),
              width: 1,
            ),
          ),
        ),
        child: SingleChildScrollView(
          controller: SidebarController.instance.scroll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(SizeConst.lg),
                  child: RoundedImage(
                    imageType: ImageType.asset,
                    image: ImageConst.logo,
                    width: 150,
                    height: 150,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),

              // const SizedBox(height: SizeConst.spaceBtwSections),

              /// SECTION LABEL
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SizeConst.lg),
                child: Text(
                  'GENERAL',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    letterSpacing: 1.2,
                    color: ColorConst.darkGrey,
                  ),
                ),
              ),

              const SizedBox(height: SizeConst.sm),

              /// DASHBOARD ITEM (ONLY)
              AdminMenuItem(
                route: AppPages.dashboard,
                title: 'Dashboard',
                icon: Iconsax.status,
              ),
              AdminMenuItem(
                route: AppPages.manageGroups,
                title: 'Manage Groups',
                icon: PhosphorIconsBold.users,
              ),
              AdminMenuItem(
                route: AppPages.manageBatches,
                title: 'Manage Batches',
                icon: Iconsax.color_swatch,
              ),
              AdminMenuItem(
                route: AppPages.allAlumni,
                title: 'All Alumni',
                icon: Iconsax.user,
              ),
              AdminMenuItem(
                route: AppPages.lifeLight,
                title: 'Life Light',
                icon: PhosphorIconsBold.flowerLotus,
              ),
              AdminMenuItem(
                route: AppPages.anubhuti,
                title: 'Anubhuti',
                icon: Iconsax.path,
              ),
              AdminMenuItem(
                route: AppPages.calender,
                title: 'Calender',
                icon: Iconsax.calendar,
              ),
              AdminMenuItem(
                route: AppPages.feedback,
                title: 'Feedback',
                icon: Iconsax.message,
              ),
              AdminMenuItem(
                route: AppPages.settings,
                title: 'Settings',
                icon: Iconsax.setting,
              ),
              const SizedBox(height: SizeConst.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
