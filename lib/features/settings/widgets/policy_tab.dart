import 'dart:developer';
import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/device/device_utility.dart';
import 'package:bhutpurva_penal/features/settings/controllers/settings_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/form_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

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
                    context,
                    title: 'Privacy Policy',
                    isActive:
                        controller.selectedPolicy.value == PolicyType.privacy,
                    onTap: () => controller.select(PolicyType.privacy),
                    showRightBorder: true,
                  ),
                  _buildTab(
                    context,
                    title: 'Activist Policy',
                    isActive:
                        controller.selectedPolicy.value == PolicyType.activist,
                    onTap: () => controller.select(PolicyType.activist),
                    showRightBorder: true,
                  ),
                  _buildTab(
                    context,
                    title: 'About App',
                    isActive:
                        controller.selectedPolicy.value == PolicyType.aboutApp,
                    onTap: () => controller.select(PolicyType.aboutApp),
                    showRightBorder: false,
                  ),
                ],
              ),
            ),
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    controller.selectedPolicy.value == PolicyType.privacy
                        ? 'Privacy Policy'
                        : controller.selectedPolicy.value == PolicyType.activist
                        ? 'Activist Policy'
                        : 'About App',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Gap(8),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      ToolBar(
                        toolBarColor: Colors.white,
                        activeIconColor: ColorConst.primary,
                        controller: controller.policyEditorController,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: QuillHtmlEditor(
                          text: controller.getPolicyContent(
                            controller.getPolicyTypeString(
                              controller.selectedPolicy.value,
                            ),
                          ),
                          hintText: 'Enter details here...',
                          controller: controller.policyEditorController,
                          isEnabled: true,
                          minHeight: 300,
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.white,
                          loadingBuilder: (context) => const SizedBox(),
                          onEditorCreated: () {
                            log("Policy Editor Created");
                            controller.fetchPolicy(
                              controller.getPolicyTypeString(
                                controller.selectedPolicy.value,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                // Align(
                //   alignment: DeviceUtility.isMobileScreen(context)
                //       ? Alignment.center
                //       : Alignment.centerRight,
                //   child: SizedBox(
                //     width: DeviceUtility.isMobileScreen(context)
                //         ? double.infinity
                //         : 200,
                // child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                      () => AdminFormButton(
                        onPressed: () => controller.updatePolicy(
                          controller.getPolicyTypeString(
                            controller.selectedPolicy.value,
                          ),
                        ),
                        isLoading: controller.isSettingsUpdateLoading.value,
                        label: 'Update',
                      ),
                    ),
                  ],
                ),
                // ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
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
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: DeviceUtility.isMobileScreen(context) ? 3 : 12,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(color: ColorConst.primary, fontSize: 13),
        ),
      ),
    );
  }
}
