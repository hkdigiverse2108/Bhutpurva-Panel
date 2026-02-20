import 'package:bhutpurva_penal/features/manage_groups/create_group/controllers/create_group_controller.dart';
import 'package:bhutpurva_penal/features/manage_groups/group_details/controllers/group_details_controller.dart';
import 'package:bhutpurva_penal/features/manage_groups/group_list/controllers/group_list_controller.dart';
import 'package:get/get.dart';

class ManageGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupListController>(() => GroupListController());
    Get.lazyPut<CreateGroupController>(() => CreateGroupController());
    Get.lazyPut<GroupDetailsController>(() => GroupDetailsController());
  }
}
