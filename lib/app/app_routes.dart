import 'package:bhutpurva_penal/app/app_middleware.dart';
import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/features/alumni/all_alumni/all_alumni.dart';
import 'package:bhutpurva_penal/features/alumni/binding/alumni_binding.dart';
import 'package:bhutpurva_penal/features/alumni/update_alumni/update_alumni.dart';
import 'package:bhutpurva_penal/features/anubhuti/anubhuti.dart';
import 'package:bhutpurva_penal/features/anubhuti/bindings/anubhuti_binding.dart';
import 'package:bhutpurva_penal/features/auth/bindings/auth_binding.dart';
import 'package:bhutpurva_penal/features/auth/login/login.dart';
import 'package:bhutpurva_penal/features/branches/Create_branch/create_branch.dart';
import 'package:bhutpurva_penal/features/branches/bindings/branches_binding.dart';
import 'package:bhutpurva_penal/features/branches/branches.dart';
import 'package:bhutpurva_penal/features/branches/edit_branch/edit_branch.dart';
import 'package:bhutpurva_penal/features/calender/bindings/calender_binding.dart';
import 'package:bhutpurva_penal/features/calender/calender.dart';
import 'package:bhutpurva_penal/features/dashboard/bindings/dashboard_binding.dart';
import 'package:bhutpurva_penal/features/dashboard/dashboard.dart';
import 'package:bhutpurva_penal/features/delete_request/bindings/delete_request_binding.dart';
import 'package:bhutpurva_penal/features/delete_request/delete_request.dart';
import 'package:bhutpurva_penal/features/feedback/bindings/feedback_binding.dart';
import 'package:bhutpurva_penal/features/feedback/feedback.dart';
import 'package:bhutpurva_penal/features/life_light/bindings/life_light_binding.dart';
import 'package:bhutpurva_penal/features/life_light/life_light.dart';
import 'package:bhutpurva_penal/features/location/bindings/location_binding.dart';
import 'package:bhutpurva_penal/features/location/create_location/create_location.dart';
import 'package:bhutpurva_penal/features/location/edit_location/edit_location.dart';
import 'package:bhutpurva_penal/features/location/location.dart';
import 'package:bhutpurva_penal/features/manage_batches/batch_details/batch_details.dart';
import 'package:bhutpurva_penal/features/manage_batches/batch_list/batch_list.dart';
import 'package:bhutpurva_penal/features/manage_batches/bindings/manage_batch_bindings.dart';
import 'package:bhutpurva_penal/features/manage_batches/create_batch/create_batch.dart';
import 'package:bhutpurva_penal/features/manage_batches/edit_batches/edit_batch.dart';
import 'package:bhutpurva_penal/features/manage_groups/bindings/manage_group_binding.dart';
import 'package:bhutpurva_penal/features/manage_groups/create_group/create_group.dart';
import 'package:bhutpurva_penal/features/manage_groups/edit_group/edit_group.dart';
import 'package:bhutpurva_penal/features/manage_groups/group_details/group_details.dart';
import 'package:bhutpurva_penal/features/manage_groups/group_list/group_list.dart';
import 'package:bhutpurva_penal/features/programs/bindings/program_binding.dart';
import 'package:bhutpurva_penal/features/programs/create_program/create_program.dart';
import 'package:bhutpurva_penal/features/programs/edit_program/edit_program.dart';
import 'package:bhutpurva_penal/features/programs/program_details/program_detail.dart';
import 'package:bhutpurva_penal/features/programs/program_list/program_list.dart';
import 'package:bhutpurva_penal/features/settings/bindings/settings_binding.dart';
import 'package:bhutpurva_penal/features/settings/settings.dart';
import 'package:bhutpurva_penal/features/survey/add_update_survey/bindings/add_update_survey_binding.dart';
import 'package:bhutpurva_penal/features/survey/add_update_survey/views/add_update_survey_view.dart';
import 'package:bhutpurva_penal/features/survey/survey_list/bindings/survey_list_binding.dart';
import 'package:bhutpurva_penal/features/survey/survey_list/views/survey_list_view.dart';
import 'package:bhutpurva_penal/features/survey/survey_responses/bindings/survey_responses_binding.dart';
import 'package:bhutpurva_penal/features/survey/survey_responses/views/survey_responses_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    // Auth
    GetPage(
      name: AppPages.login,
      page: () => const Login(),
      binding: AuthBinding(),
    ),

    // Dashboard
    GetPage(
      name: AppPages.dashboard,
      page: () => const Dashboard(),
      binding: DashboardBinding(),
      middlewares: [AppMiddleware()],
    ),

    // group
    GetPage(
      name: AppPages.manageGroups,
      page: () => const GroupList(),
      binding: ManageGroupBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.createGroup,
      page: () => const CreateGroup(),
      binding: ManageGroupBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.editGroup,
      page: () => const EditGroup(),
      binding: ManageGroupBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.groupDetails,
      page: () => const GroupDetails(),
      binding: ManageGroupBinding(),
      middlewares: [AppMiddleware()],
    ),

    // batch
    GetPage(
      name: AppPages.manageBatches,
      page: () => const BatchList(),
      binding: ManageBatchBindings(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.createBatch,
      page: () => const CreateBatch(),
      binding: ManageBatchBindings(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.editBatch,
      page: () => const EditBatch(),
      binding: ManageBatchBindings(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.batchDetails,
      page: () => const BatchDetails(),
      binding: ManageBatchBindings(),
      middlewares: [AppMiddleware()],
    ),

    // alumni
    GetPage(
      name: AppPages.allAlumni,
      page: () => const AllAlumni(),
      binding: AlumniBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.editAlumni,
      page: () => const UpdateAlumni(),
      binding: AlumniBinding(),
      middlewares: [AppMiddleware()],
    ),

    // life-light
    GetPage(
      name: AppPages.lifeLight,
      page: () => LifeLight(),
      binding: LifeLightBinding(),
      middlewares: [AppMiddleware()],
    ),

    // anubhuti
    GetPage(
      name: AppPages.anubhuti,
      page: () => Anubhuti(),
      binding: AnubhutiBinding(),
      middlewares: [AppMiddleware()],
    ),

    // branches
    GetPage(
      name: AppPages.branches,
      page: () => Branches(),
      binding: BranchesBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.createBranch,
      page: () => const CreateBranch(),
      binding: BranchesBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.editBranch,
      page: () => const EditBranch(),
      binding: BranchesBinding(),
      middlewares: [AppMiddleware()],
    ),

    // location
    GetPage(
      name: AppPages.location,
      page: () => Location(),
      binding: LocationBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.createLocation,
      page: () => const CreateLocation(),
      binding: LocationBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.editLocation,
      page: () => const EditLocation(),
      binding: LocationBinding(),
      middlewares: [AppMiddleware()],
    ),

    // calender
    GetPage(
      name: AppPages.calender,
      page: () => Calender(),
      binding: CalenderBinding(),
      middlewares: [AppMiddleware()],
    ),

    // feedback
    GetPage(
      name: AppPages.feedback,
      page: () => const Feedback(),
      binding: FeedbackBinding(),
      middlewares: [AppMiddleware()],
    ),

    // settings
    GetPage(
      name: AppPages.settings,
      page: () => const Settings(),
      binding: SettingsBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.managePrograms,
      page: () => const ProgramList(),
      binding: ProgramBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.createProgram,
      page: () => const CreateProgram(),
      binding: ProgramBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.editProgram,
      page: () => const EditProgram(),
      binding: ProgramBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.programDetails,
      page: () => const ProgramDetail(),
      binding: ProgramBinding(),
      middlewares: [AppMiddleware()],
    ),
<<<<<<< HEAD
    GetPage(
      name: AppPages.deleteRequest,
      page: () => const DeleteRequest(),
      binding: DeleteRequestBinding(),
=======

    // surveys
    GetPage(
      name: AppPages.manageSurveys,
      page: () => const SurveyListView(),
      binding: SurveyListBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.createSurvey,
      page: () => const AddUpdateSurveyView(),
      binding: AddUpdateSurveyBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: AppPages.editSurvey,
      page: () => const AddUpdateSurveyView(),
      binding: AddUpdateSurveyBinding(),
      middlewares: [AppMiddleware()],
    ),
    GetPage(
      name: '/survey-responses/:id',
      page: () => const SurveyResponsesView(),
      binding: SurveyResponsesBinding(),
>>>>>>> 3d57f6d854def1747577e2418de83d20c1e38915
      middlewares: [AppMiddleware()],
    ),
  ];
}
