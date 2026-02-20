import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AdminFormSectionCard(
        title: 'Notifications',
        subtitle: 'Stay updated with your latest news and updates',
        fields: [
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorConst.lightGrey,
            ),
            child: Row(
              children: [
                Text('All', style: TextStyle(fontWeight: FontWeight.bold)),
                Gap(10),
                Text('Unread (2)', style: TextStyle(color: ColorConst.grey)),
                Spacer(),
                InkWell(
                  onTap: () {},
                  child: Text(
                    '✓✓ Mark all as Read',
                    style: TextStyle(color: ColorConst.primary),
                  ),
                ),
              ],
            ),
          ),
          Text('Today'),
          ...List.generate(
            3,
            (index) => Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorConst.softGrey,
                  ),
                ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notification Title',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'July 16. 2024 | 09:00 PM',
                      style: TextStyle(color: ColorConst.grey),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  PhosphorIconsBold.dot,
                  color: ColorConst.primary,
                  size: 50,
                ),
              ],
            ),
          ),
          Text('Tomorrow'),
          ...List.generate(
            5,
            (index) => Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorConst.softGrey,
                  ),
                ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notification Title',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'July 16. 2024 | 09:00 PM',
                      style: TextStyle(color: ColorConst.grey),
                    ),
                  ],
                ),
                Spacer(),
                Visibility(
                  visible: false,
                  child: Icon(
                    PhosphorIconsBold.dot,
                    color: ColorConst.primary,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
          Text('July 16. 2024'),
          ...List.generate(
            3,
            (index) => Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorConst.softGrey,
                  ),
                ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notification Title',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'July 16. 2024 | 09:00 PM',
                      style: TextStyle(color: ColorConst.grey),
                    ),
                  ],
                ),
                Spacer(),
                Visibility(
                  visible: false,
                  child: Icon(
                    PhosphorIconsBold.dot,
                    color: ColorConst.primary,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
