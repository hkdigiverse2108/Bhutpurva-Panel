import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/shared/headings/page_heading.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BreadcrumbWithHeading extends StatelessWidget {
  final String heading;
  final List<BreadcrumbItem> breadcrumbsItems;
  final bool showDashboard;
  final bool returnToPreviousScreen;
  final List<Widget>? actions;

  const BreadcrumbWithHeading({
    super.key,
    required this.heading,
    required this.breadcrumbsItems,
    this.showDashboard = true,
    this.returnToPreviousScreen = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// BREADCRUMBS
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              /// DASHBOARD (ROOT)
              if (showDashboard)
                InkWell(
                  onTap: () => Get.offAllNamed(AppPages.dashboard),
                  child: Padding(
                    padding: const EdgeInsets.all(SizeConst.xs),
                    child: Text(
                      'Dashboard',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                    ),
                  ),
                ),

              /// BREADCRUMB ITEMS
              for (int i = 0; i < breadcrumbsItems.length; i++) ...[
                if (showDashboard || i > 0)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(Iconsax.arrow_right_3, size: 14),
                  ),
                InkWell(
                  onTap: breadcrumbsItems[i].route == null
                      ? null
                      : () => Get.offNamed(breadcrumbsItems[i].route!),
                  child: Padding(
                    padding: const EdgeInsets.all(SizeConst.xs),
                    child: Text(
                      breadcrumbsItems[i].title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                        fontWeightDelta: breadcrumbsItems[i].route == null
                            ? 0
                            : -1,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        const Gap(SizeConst.sm),

        /// HEADING
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (returnToPreviousScreen)
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Iconsax.arrow_left),
                      ),
                    if (returnToPreviousScreen) const Gap(SizeConst.spaceBtwItems),
                    PageHeadings(heading: heading),
                  ],
                ),
              ),
            ),
            if (actions != null) ...[
              const Gap(SizeConst.spaceBtwItems),
              Row(children: actions!),
            ],
          ],
        ),
      ],
    );
  }
}
