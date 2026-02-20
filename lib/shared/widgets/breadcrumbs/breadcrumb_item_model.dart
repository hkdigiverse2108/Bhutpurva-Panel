/// Breadcrumb item model
///
/// Navigation rules:
/// - Dashboard is considered a ROOT route and should always use `Get.offAllNamed`
/// - Other breadcrumb navigation should use `Get.offNamed`
/// - Current page breadcrumb must have `route = null`
///
/// This is intentionally explicit to avoid:
/// - route guessing
/// - string manipulation
/// - fragile UI behavior on web
class BreadcrumbItem {
  final String title;
  final String? route;

  const BreadcrumbItem({required this.title, this.route});
}
