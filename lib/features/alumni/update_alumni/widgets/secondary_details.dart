import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/features/alumni/update_alumni/controllers/update_alumni_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SecondaryDetails extends StatelessWidget {
  const SecondaryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UpdateAlumniController.instance;
    return Column(
      children: [
        AdminFormSectionCard(
          title: 'Occupation Information',
          fields: [
            Column(
              children: [
                Obx(
                  () => CheckboxListTile(
                    value: controller.isStudent.value,
                    onChanged: (value) {
                      controller.isStudent.value = value ?? false;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    checkboxScaleFactor: 0.8,
                    title: const Text(
                      "Is a Student",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                Obx(
                  () => CheckboxListTile(
                    value: controller.runsBusiness.value,
                    onChanged: (value) {
                      controller.runsBusiness.value = value ?? false;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    checkboxScaleFactor: 0.8,

                    title: const Text(
                      "Run's Business",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                Obx(
                  () => CheckboxListTile(
                    value: controller.isEmployee.value,
                    onChanged: (value) {
                      controller.isEmployee.value = value ?? false;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    checkboxScaleFactor: 0.8,

                    title: const Text(
                      "Is an Employee",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                Obx(
                  () => CheckboxListTile(
                    value: controller.isSelfEmployed.value,
                    onChanged: (value) {
                      controller.isSelfEmployed.value = value ?? false;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    checkboxScaleFactor: 0.8,

                    title: const Text(
                      "Is Self Employee",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                Obx(
                  () => CheckboxListTile(
                    value: controller.isRetired.value,
                    onChanged: (value) {
                      controller.isRetired.value = value ?? false;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    checkboxScaleFactor: 0.8,

                    title: const Text(
                      "Is Retired",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
            AdminSearchSelectField<String>(
              label: 'Profession',
              items: controller.professionsList
                  .map((e) => AdminDropdownItem<String>(value: e, label: e))
                  .toList(),
              onChanged: (value) {
                if (value == null) return;

                if (!controller.professions.contains(value)) {
                  controller.professions.add(value);
                }
              },
            ),
            Obx(
              () => Wrap(
                spacing: 10,
                runSpacing: 10,
                children: controller.professions.map((e) {
                  return GestureDetector(
                    onLongPress: () => controller.professions.remove(e),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorConst.primary.withValues(alpha: 0.5),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            ColorConst.primary.withValues(alpha: 0.3),
                            ColorConst.primary.withValues(alpha: 0.2),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                            color: Colors.black.withValues(alpha: 0.08),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            e,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => controller.professions.remove(e),
                            child: const Icon(
                              PhosphorIconsRegular.x,
                              size: 14,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            AdminSearchSelectField<String>(
              label: 'Education',
              items: controller.educationsList
                  .map((e) => AdminDropdownItem<String>(value: e, label: e))
                  .toList(),
              onChanged: (value) {
                if (value == null) return;

                if (!controller.educations.contains(value)) {
                  controller.educations.add(value);
                }
              },
            ),
            Obx(
              () => Wrap(
                spacing: 10,
                runSpacing: 10,
                children: controller.educations.map((e) {
                  return GestureDetector(
                    onLongPress: () => controller.educations.remove(e),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorConst.primary.withValues(alpha: 0.5),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            ColorConst.primary.withValues(alpha: 0.3),
                            ColorConst.primary.withValues(alpha: 0.2),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                            color: Colors.black.withValues(alpha: 0.08),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            e,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => controller.educations.remove(e),
                            child: const Icon(
                              PhosphorIconsRegular.x,
                              size: 14,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: AdminSearchSelectField(
                    label: 'Select Marital Status',
                    items: controller.meritStatusList
                        .map(
                          (e) => AdminDropdownItem<String>(value: e, label: e),
                        )
                        .toList(),
                    value: controller.maritalStatus.value,
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AdminSearchSelectField(
                    label: 'Select Blood Group',
                    items: controller.bloodGroupsList
                        .map(
                          (e) => AdminDropdownItem<String>(value: e, label: e),
                        )
                        .toList(),
                    value: controller.bloodGroup.value,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
