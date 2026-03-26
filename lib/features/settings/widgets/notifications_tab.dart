import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);

    return AdminFormSectionCard(
      title: 'Notifications',
      subtitle: 'Stay updated with your latest news and updates',
      fields: [
        _header(context, mobile),

        const Text('Today'),
        const Gap(10),
        ...List.generate(3, (index) => _notificationItem(mobile, true)),

        const Gap(15),
        const Text('Tomorrow'),
        const Gap(10),
        ...List.generate(5, (index) => _notificationItem(mobile, false)),

        const Gap(15),
        const Text('July 16. 2024'),
        const Gap(10),
        ...List.generate(3, (index) => _notificationItem(mobile, false)),
      ],
    );
  }

  // 🔹 Header (Responsive)
  Widget _header(BuildContext context, bool mobile) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConst.lightGrey,
      ),
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text('All', style: TextStyle(fontWeight: FontWeight.bold)),
                    Gap(10),
                    Text(
                      'Unread (2)',
                      style: TextStyle(color: ColorConst.grey),
                    ),
                  ],
                ),
                const Gap(10),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    '✓✓ Mark all as Read',
                    style: TextStyle(color: ColorConst.primary),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                const Text(
                  'All',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                const Text(
                  'Unread (2)',
                  style: TextStyle(color: ColorConst.grey),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    '✓✓ Mark all as Read',
                    style: TextStyle(color: ColorConst.primary),
                  ),
                ),
              ],
            ),
    );
  }

  // 🔹 Notification Item (Responsive)
  Widget _notificationItem(bool mobile, bool showDot) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _iconBox(),
                    const Gap(10),
                    Expanded(child: _textContent()),
                    if (showDot)
                      const Icon(
                        PhosphorIconsBold.dot,
                        color: ColorConst.primary,
                        size: 20,
                      ),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                _iconBox(),
                const Gap(10),
                Expanded(child: _textContent()),
                if (showDot)
                  const Icon(
                    PhosphorIconsBold.dot,
                    color: ColorConst.primary,
                    size: 50,
                  ),
              ],
            ),
    );
  }

  Widget _iconBox() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConst.softGrey,
      ),
    );
  }

  Widget _textContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notification Title',
          style: TextStyle(fontWeight: FontWeight.w700),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          'July 16, 2024 | 09:00 PM',
          style: TextStyle(color: ColorConst.grey),
        ),
      ],
    );
  }
}
