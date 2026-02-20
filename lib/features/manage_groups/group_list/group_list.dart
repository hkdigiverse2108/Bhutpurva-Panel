import 'package:bhutpurva_penal/features/manage_groups/group_list/responsive/group_list_desktop.dart';
import 'package:bhutpurva_penal/features/manage_groups/group_list/responsive/group_list_mobile.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayouts(
      desktop: const GroupListDesktop(),
      mobile: const GroupListMobile(),
    );
  }
}
