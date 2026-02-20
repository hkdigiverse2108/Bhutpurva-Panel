class AppPages {
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  // group
  static const String manageGroups = '/manage-groups';
  static const String createGroup = '/create-group';
  static const String editGroup = '/edit-group';
  static const String groupDetails = '/group-details';

  // batches
  static const String manageBatches = '/manage-batches';
  static const String createBatch = '/create-batch';
  static const String editBatch = '/edit-batch';
  static const String batchDetails = '/batch-details';

  // alumni
  static const String allAlumni = '/all-alumni';
  static const String editAlumni = '/edit-alumni';

  // life light
  static const String lifeLight = '/life-light';

  // anubhuti
  static const String anubhuti = '/anubhuti';

  // calender
  static const String calender = '/calender';

  // feedback
  static const String feedback = '/feedback';

  // settings
  static const String settings = '/settings';

  static const List<String> sidebarMenuItems = [
    dashboard,
    manageGroups,
    manageBatches,
    allAlumni,
    lifeLight,
    anubhuti,
    calender,
    feedback,
    settings,
  ];
}
