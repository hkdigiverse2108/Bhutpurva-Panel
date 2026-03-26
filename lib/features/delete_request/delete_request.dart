import 'package:bhutpurva_penal/shared/widgets/layouts/templates/site_layouts.dart';
import 'package:flutter/material.dart';

import 'responsive/delete_request_desktop.dart';

class DeleteRequest extends StatelessWidget {
  const DeleteRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SiteLayouts(desktop: DeleteRequestDesktop()));
  }
}
