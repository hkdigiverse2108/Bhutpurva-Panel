import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/constants/image_const.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/core/device/device_utility.dart';
import 'package:bhutpurva_penal/core/helpers/helpers.dart';
import 'package:bhutpurva_penal/core/services/storage_service.dart';
import 'package:bhutpurva_penal/shared/widgets/images/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MenuItem {
  final String title;
  final String route;
  final IconData? icon;
  final List<MenuItem>? children;

  MenuItem({
    required this.title,
    required this.route,
    this.icon,
    this.children,
  });

  // Convert all menu items to a flat list for searching
  static List<MenuItem> getAllItems() {
    return [];
  }

  // Get all items including children as a flat list
  static List<MenuItem> getFlatItems() {
    List<MenuItem> allItems = [];
    for (var item in getAllItems()) {
      allItems.add(item);
      if (item.children != null) {
        allItems.addAll(item.children!);
      }
    }
    return allItems;
  }
}

class _MenuSearchDelegate extends SearchDelegate<String> {
  final List<MenuItem> menuItems;

  _MenuSearchDelegate({required this.menuItems});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = menuItems
        .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: item.icon != null ? Icon(item.icon) : null,
          title: Text(item.title),
          onTap: () {
            Get.toNamed(item.route);
            close(context, item.title);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : menuItems
              .where(
                (item) =>
                    item.title.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return ListTile(
          leading: item.icon != null ? Icon(item.icon) : null,
          title: Text(item.title),
          onTap: () {
            close(context, item.title);
            Future.microtask(() => Get.toNamed(item.route));
          },
        );
      },
    );
  }
}

class Header extends StatelessWidget implements PreferredSizeWidget {
  final List<MenuItem> menuItems;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const Header({super.key, this.menuItems = const [], this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    final store = StorageService.instance;
    return Container(
      decoration: BoxDecoration(
        color: HelperFunctions.isDarkMode(context)
            ? ColorConst.black
            : ColorConst.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: -5,
            offset: Offset(0, -5),
          ),
        ],
        // border: Border(bottom: BorderSide(color: ColorConst.grey, width: 1)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConst.md,
        vertical: SizeConst.sm,
      ),
      child: AppBar(
        scrolledUnderElevation: 0,
        leading: !DeviceUtility.isDesktopScreen(context)
            ? IconButton(
                onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                icon: const Icon(Iconsax.menu, fill: 0.0),
              )
            : null,
        automaticallyImplyLeading: false,
        title: DeviceUtility.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search anything....",
                    prefixIcon: const Icon(Iconsax.search_normal, fill: 0.0),
                  ),
                  onFieldSubmitted: (value) {
                    // open search delegate
                    showSearch(
                      context: context,
                      delegate: _MenuSearchDelegate(
                        menuItems: menuItems.isNotEmpty
                            ? menuItems
                            : MenuItem.getFlatItems(),
                      ),
                      query: value,
                    );
                  },
                ),
              )
            : null,
        actions: [
          if (!DeviceUtility.isDesktopScreen(context))
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: _MenuSearchDelegate(
                    menuItems: menuItems.isNotEmpty
                        ? menuItems
                        : MenuItem.getFlatItems(),
                  ),
                );
              },
              icon: const Icon(Iconsax.search_normal, fill: 0.0),
            ),
          IconButton(
            onPressed: () {},
            icon: Icon(Iconsax.notification, fill: 0.0),
          ),
          const SizedBox(width: SizeConst.spaceBtwItems / 2),

          /// User Profile
          PopupMenuButton<_ProfileAction>(
            tooltip: '',
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 8,
            onSelected: (value) {
              switch (value) {
                case _ProfileAction.changePassword:
                  debugPrint('Change Password');
                  break;
                case _ProfileAction.logout:
                  showLogoutConfirmationBottomSheet(context, () {
                    debugPrint('Logged out');

                    store.clearAll();
                    Get.offAllNamed(AppPages.login);
                  });
                  break;
              }
            },
            itemBuilder: (context) => [
              // PopupMenuItem(
              //   enabled: false,
              //   height: 70,
              //   child: _ProfileHeader(),
              // ),
              // const PopupMenuDivider(),
              PopupMenuItem(
                value: _ProfileAction.changePassword,
                child: _ProfileMenuRow(
                  icon: Icons.lock_outline,
                  label: 'Change Password',
                ),
              ),
              PopupMenuItem(
                value: _ProfileAction.logout,
                child: _ProfileMenuRow(
                  icon: Icons.logout,
                  label: 'Logout',
                  color: Colors.red,
                ),
              ),
            ],
            child: _AvatarButton(store: store),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(DeviceUtility.getAppBarHeight() + 15);
}

Future<void> showLogoutConfirmationBottomSheet(
  BuildContext context,
  VoidCallback onConfirm,
) async {
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    builder: (context) {
      return SafeArea(
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                'Logout?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Are you sure you want to log out of your account?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white30),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _ProfileMenuRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _ProfileMenuRow({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final textColor = color ?? Theme.of(context).textTheme.bodyMedium!.color;

    return Row(
      children: [
        Icon(icon, size: 18, color: textColor),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _AvatarButton extends StatelessWidget {
  final StorageService store;

  const _AvatarButton({required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        // border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        children: [
          RoundedImage(
            imageType: ImageType.asset,
            image: ImageConst.logo,
            width: 50,
            height: 50,
          ),
          Gap(SizeConst.sm),
          if (!DeviceUtility.isMobileScreen(context))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  store.user?.email.split('@').first ?? 'Admin',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  store.user?.email ?? 'Admin@gmail.com',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}

enum _ProfileAction { changePassword, logout }
