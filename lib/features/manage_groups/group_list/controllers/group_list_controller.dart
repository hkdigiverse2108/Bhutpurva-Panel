import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/shared/models/group_models/group_model.dart';
import 'package:bhutpurva_penal/shared/widgets/menu/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupListController extends GetxController {
  static GroupListController get instance => Get.find();

  var groups = <GroupModel>[].obs;
  var isLoading = true.obs;
  var statusFilterLabel = 'Status'.obs;

  int page = 0;
  int rowsPerPage = 10;
  int total = 0;

  final searchController = TextEditingController();
  var query = ''.obs;

  bool? statusFilter;

  bool get isStatusFilterActive => statusFilter != null;

  late Worker _searchWorker;

  @override
  void onInit() {
    super.onInit();

    _searchWorker = debounce(query, (_) {
      page = 0;
      fetchUsers();
    }, time: const Duration(milliseconds: 400));

    fetchUsers();
  }

  void fetchUsers() async {
    isLoading.value = true;

    // 🔥 API params you will eventually pass:
    // page, rowsPerPage, query.value, statusFilter

    await Future.delayed(const Duration(seconds: 1));

    groups.value = List.generate(
      10,
      (i) => GroupModel(
        id: i,
        name: "Group $i ${query.value}",
        description: "Description $i",
        isActive: statusFilter ?? (i % 2 == 0),
      ),
    );

    total = 50;
    isLoading.value = false;
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChange(int value) {
    page = value ~/ rowsPerPage;
    fetchUsers();
  }

  void setStatusFilter(bool? value) {
    statusFilter = value;
    page = 0;
    fetchUsers();
  }

  void clearFilters() {
    statusFilter = null;
    page = 0;
    fetchUsers();
  }

  void onCreateGroup() {
    Get.toNamed(AppPages.createGroup);
  }

  void showStatusFilterMenu({
    required BuildContext context,
    required GroupListController controller,
    required LayerLink link,
  }) {
    final overlay = Overlay.of(context);

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        return Positioned.fill(
          child: Stack(
            children: [
              // click outside to close
              GestureDetector(
                onTap: () => entry.remove(),
                behavior: HitTestBehavior.translucent,
              ),

              // menu follows the button perfectly
              CompositedTransformFollower(
                link: link,
                offset: const Offset(0, 42), // below button
                showWhenUnlinked: false,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(8),
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OverlayMenuItem<bool?>(
                          label: "All",
                          value: null,
                          selectedValue: controller.statusFilter,
                          onSelected: (val) {
                            controller.setStatusFilter(val);
                            entry.remove();
                          },
                        ),
                        OverlayMenuItem<bool?>(
                          label: "Active",
                          value: true,
                          selectedValue: controller.statusFilter,
                          onSelected: (val) {
                            controller.setStatusFilter(val);
                            entry.remove();
                          },
                        ),
                        OverlayMenuItem<bool?>(
                          label: "Inactive",
                          value: false,
                          selectedValue: controller.statusFilter,
                          onSelected: (val) {
                            controller.setStatusFilter(val);
                            entry.remove();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    overlay.insert(entry);
  }

  void onGroupTap(GroupModel group) {
    Get.toNamed(AppPages.groupDetails, arguments: group);
  }

  @override
  void onClose() {
    _searchWorker.dispose();
    searchController.dispose();
    super.onClose();
  }
}
