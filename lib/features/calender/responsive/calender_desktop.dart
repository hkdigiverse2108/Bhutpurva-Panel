import 'dart:ui';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/core/device/device_utility.dart';
import 'package:bhutpurva_penal/features/calender/controllers/calender_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        heading: 'Tithi Calendar',
        breadcrumbsItems: [BreadcrumbItem(title: 'Calendar Management')],
      ),
      toolbar: AdminTableToolbar(
        actions: [
          TableActionButton(
            onTap: () {},
            label: 'Add Next Calendar',
            icon: Icons.add,
            color: ColorConst.primary,
          ),
          const Gap(10),
          TableActionButton(
            onTap: () {},
            label: 'Quick Update',
            icon: Icons.sync,
            color: ColorConst.primary,
          ),
          const Gap(SizeConst.spaceBtwItems),
        ],
      ),
      body: Column(
        children: [
          _buildYearSelector(controller),
          const Gap(SizeConst.spaceBtwSections),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ColorConst.white,
                borderRadius: BorderRadius.circular(SizeConst.cardRadiusLg),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: EdgeInsets.all(
                DeviceUtility.isDesktopScreen(context)
                    ? SizeConst.xl
                    : SizeConst.md,
              ),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: ColorConst.primary),
                  );
                }

                return Stack(
                  children: [
                    GridView.builder(
                      padding: const EdgeInsets.all(12), // Buffer for scale
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        crossAxisSpacing: DeviceUtility.isDesktopScreen(context)
                            ? SizeConst.spaceBtwSections
                            : SizeConst.md,
                        mainAxisSpacing: DeviceUtility.isDesktopScreen(context)
                            ? SizeConst.xl
                            : SizeConst.md,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: controller.uiMonths.length,
                      itemBuilder: (context, index) {
                        String uiMonth = controller.uiMonths[index];
                        String? imageUrl = controller.getImageForMonth(uiMonth);

                        return _MonthCard(
                          month: uiMonth,
                          imageUrl: imageUrl,
                          onTap: () => controller.uploadImageForMonth(uiMonth),
                        );
                      },
                    ),
                    if (controller.isUploading.value)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(
                              SizeConst.cardRadiusMd,
                            ),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                  color: ColorConst.primary,
                                ),
                                Gap(SizeConst.spaceBtwItems),
                                Text(
                                  'Uploading...',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorConst.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearSelector(CalenderController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ColorConst.softGrey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _YearNavButton(
            icon: Icons.chevron_left,
            onPressed: () {
              controller.year.value--;
              controller.fetchCalendar();
            },
          ),
          const Gap(20),
          Obx(
            () => Text(
              '${controller.year.value}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: ColorConst.primary,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const Gap(20),
          _YearNavButton(
            icon: Icons.chevron_right,
            onPressed: () {
              controller.year.value++;
              controller.fetchCalendar();
            },
          ),
        ],
      ),
    );
  }
}

class _YearNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _YearNavButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorConst.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Icon(icon, color: ColorConst.primary, size: 24),
        ),
      ),
    );
  }
}

class _MonthCard extends StatefulWidget {
  final String month;
  final String? imageUrl;
  final VoidCallback onTap;

  const _MonthCard({required this.month, this.imageUrl, required this.onTap});

  @override
  State<_MonthCard> createState() => _MonthCardState();
}

class _MonthCardState extends State<_MonthCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(8), // Room for scale animation
          child: AnimatedScale(
            scale: _isHovered ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: ColorConst.white,
                borderRadius: BorderRadius.circular(SizeConst.cardRadiusLg),
                border: Border.all(
                  color: _isHovered
                      ? ColorConst.primary.withValues(alpha: 0.5)
                      : ColorConst.primary.withValues(alpha: 0.1),
                  width: _isHovered ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? ColorConst.primary.withValues(alpha: 0.1)
                        : Colors.black.withValues(alpha: 0.02),
                    blurRadius: _isHovered ? 15 : 10,
                    offset: Offset(0, _isHovered ? 8 : 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: SizeConst.md),
                    decoration: BoxDecoration(
                      color: _isHovered
                          ? ColorConst.primary.withValues(alpha: 0.05)
                          : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(SizeConst.cardRadiusLg),
                        topRight: Radius.circular(SizeConst.cardRadiusLg),
                      ),
                    ),
                    child: Text(
                      widget.month,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: SizeConst.fontSizeMd,
                        color: _isHovered ? ColorConst.primary : Colors.black87,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(SizeConst.md),
                      child: widget.imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                SizeConst.cardRadiusMd,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: (widget.imageUrl!.startsWith("http"))
                                    ? widget.imageUrl!
                                    : ApiConstants.baseUrl + widget.imageUrl!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: ColorConst.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                      Icons.image_not_supported_outlined,
                                      color: Colors.grey,
                                    ),
                              ),
                            )
                          : CustomPaint(
                              painter: _DashedBorderPainter(
                                color: _isHovered
                                    ? ColorConst.primary.withValues(alpha: 0.4)
                                    : Colors.grey.withValues(alpha: 0.3),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 32,
                                      color: _isHovered
                                          ? ColorConst.primary.withValues(
                                              alpha: 0.6,
                                            )
                                          : Colors.grey.withValues(alpha: 0.4),
                                    ),
                                    const Gap(8),
                                    Text(
                                      'Upload',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _isHovered
                                            ? ColorConst.primary.withValues(
                                                alpha: 0.6,
                                              )
                                            : Colors.grey.withValues(
                                                alpha: 0.4,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;

  _DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final double dashWidth = 5;
    final double dashSpace = 3;
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(SizeConst.cardRadiusMd),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashPath = Path();

    for (final PathMetric metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        dashPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
