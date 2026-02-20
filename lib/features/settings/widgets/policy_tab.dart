import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/features/settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PolicyTab extends StatelessWidget {
  const PolicyTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConst.primary.withValues(alpha: 0.3)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: ColorConst.primary.withValues(alpha: 0.3),
                ),
              ),
            ),
            child: Obx(
              () => Row(
                children: [
                  _buildTab(
                    title: 'Privacy Policy',
                    isActive:
                        controller.selectedPolicy.value == PolicyType.privacy,
                    onTap: () => controller.select(PolicyType.privacy),
                    showRightBorder: true,
                  ),
                  _buildTab(
                    title: 'Activist Policy',
                    isActive:
                        controller.selectedPolicy.value == PolicyType.activist,
                    onTap: () => controller.select(PolicyType.activist),
                    showRightBorder: false,
                  ),
                ],
              ),
            ),
          ),

          const Gap(8),

          Obx(
            () => Padding(
              padding: const EdgeInsets.all(10),
              child: controller.selectedPolicy.value == PolicyType.privacy
                  ? _privacyPolicy()
                  : _activistPolicy(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String title,
    required bool isActive,
    required VoidCallback onTap,
    required bool showRightBorder,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isActive ? ColorConst.primary.withValues(alpha: 0.1) : null,
          border: Border(
            right: showRightBorder
                ? BorderSide(color: ColorConst.primary.withValues(alpha: 0.3))
                : BorderSide.none,
            top: BorderSide(
              color: isActive
                  ? ColorConst.primary.withValues(alpha: 0.8)
                  : Colors.transparent,
              width: isActive ? 2 : 0,
            ),
            // bottom: BorderSide(color: Colors.white),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        child: Text(title, style: const TextStyle(color: ColorConst.primary)),
      ),
    );
  }

  Widget _privacyPolicy() {
    final controller = SettingsController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Privacy Policy',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const Gap(8),

        TextFormField(
          controller: controller.privacyPolicyController,
          maxLines: 40,
          minLines: 20,
          decoration: InputDecoration(
            hintText: 'Enter privacy policy details here...',
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ColorConst.primary, width: 1.2),
            ),
          ),
        ),
        const Gap(8),
        Align(
          alignment: AlignmentGeometry.centerRight,
          child: SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Update'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _activistPolicy() {
    final controller = SettingsController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activist Policy',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const Gap(8),

        TextFormField(
          controller: controller.privacyPolicyController,
          maxLines: 40,
          minLines: 20,
          decoration: InputDecoration(
            hintText: 'Enter activist policy details here...',
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ColorConst.primary, width: 1.2),
            ),
          ),
        ),
        const Gap(8),
        Align(
          alignment: AlignmentGeometry.centerRight,
          child: SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Update'),
            ),
          ),
        ),
      ],
    );
  }
}
