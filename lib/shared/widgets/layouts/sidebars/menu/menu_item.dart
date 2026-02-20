import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/sidebars/controllers/sidebar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AdminMenuItem extends StatefulWidget {
  const AdminMenuItem({
    super.key,
    required this.route,
    required this.title,
    required this.icon,
    this.subItems,
  });

  final String route;
  final String title;
  final IconData icon;
  final List<AdminMenuItem>? subItems; // ✅ Optional nested menu items

  @override
  State<AdminMenuItem> createState() => _AdminMenuItemState();
}

class _AdminMenuItemState extends State<AdminMenuItem> {
  final manuController = Get.put(SidebarController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (widget.subItems != null && widget.subItems!.isNotEmpty) {
                // Toggle expansion for items with children
                manuController.toggleExpand(widget.route);
              } else {
                manuController.menuOnTap(widget.route);
              }
            },
            onHover: (hovering) => hovering
                ? manuController.changeHoverItem(widget.route)
                : manuController.changeHoverItem(''),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: SizeConst.xs),
              child: Container(
                decoration: BoxDecoration(
                  color: manuController.isActive(widget.route)
                      ? ColorConst.primary.withOpacity(0.08)
                      : manuController.isHovering(widget.route)
                      ? ColorConst.grey.withOpacity(0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(SizeConst.cardRadiusMd),
                ),
                child: Row(
                  children: [
                    /// ACTIVE INDICATOR
                    Container(
                      width: 3,
                      height: 40,
                      decoration: BoxDecoration(
                        color: manuController.isActive(widget.route)
                            ? ColorConst.primary
                            : Colors.transparent,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(4),
                        ),
                      ),
                    ),

                    /// ICON
                    Padding(
                      padding: const EdgeInsets.only(
                        left: SizeConst.md,
                        right: SizeConst.md,
                      ),
                      child: Icon(
                        widget.icon,
                        size: 22,
                        color: manuController.isActive(widget.route)
                            ? ColorConst.primary
                            : ColorConst.darkGrey,
                      ),
                    ),

                    /// TITLE
                    Expanded(
                      child: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: manuController.isActive(widget.route)
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: manuController.isActive(widget.route)
                              ? ColorConst.primary
                              : ColorConst.darkGrey,
                        ),
                      ),
                    ),

                    if (widget.subItems != null && widget.subItems!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Iconsax.arrow_down_2),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Submenu items (visible when expanded)
          if (widget.subItems != null &&
              widget.subItems!.isNotEmpty &&
              manuController.isExpanded(widget.route))
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Column(
                children: widget.subItems!.map((subItem) {
                  // Pass the parent route to sub-items
                  return Builder(builder: (context) => subItem);
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
