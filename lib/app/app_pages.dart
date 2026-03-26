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

  // branches
  static const String branches = '/branches';
  static const String createBranch = '/create-branch';
  static const String editBranch = '/edit-branch';

  // location
  static const String location = '/location';
  static const String createLocation = '/create-location';
  static const String editLocation = '/edit-location';

  // calender
  static const String calender = '/calender';

  // feedback
  static const String feedback = '/feedback';

  // settings
  static const String settings = '/settings';

  // programs
  static const String managePrograms = '/manage-programs';
  static const String createProgram = '/create-program';
  static const String editProgram = '/edit-program';
  static const String programDetails = '/program-details';
  static const String editAttendance = '/edit-attendance';

  // surveys
  static const String manageSurveys = '/manage-surveys';
  static const String createSurvey = '/create-survey';
  static const String editSurvey = '/edit-survey';
  static String surveyResponses(String id) => '/survey-responses/$id';
  // delete request
  static const String deleteRequest = '/delete-request';

  static const List<String> sidebarMenuItems = [
    dashboard,
    manageGroups,
    manageBatches,
    managePrograms,
    allAlumni,
    lifeLight,
    anubhuti,
    calender,
    feedback,
    settings,
    manageSurveys,
    deleteRequest,
  ];
}
