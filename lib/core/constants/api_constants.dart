class ApiConstants {
  static const baseUrl = 'http://localhost:5000/';

  // Helper method to build URLs with query parameters
  static String _buildUrl(String path, Map<String, dynamic> params) {
    final List<String> queryParts = [];
    params.forEach((key, value) {
      if (value != null && value.toString().isNotEmpty) {
        queryParts.add('$key=${Uri.encodeComponent(value.toString())}');
      }
    });

    if (queryParts.isEmpty) return path;
    return '$path?${queryParts.join('&')}';
  }

  static const login = 'auth/login';
  static const changePassword = 'auth/change-password';

  // groups
  static String groupsDropdown(String query) =>
      _buildUrl('group/dropdown', {'search': query});
  static const createGroup = 'group/create';
  static const updateGroup = 'group/update';
  static String groupDetails(String id) => 'group/get/$id';
  static String groups({
    int page = 1,
    int? limit,
    String? query,
    bool? status,
  }) {
    return _buildUrl('group/get', {
      'page': page,
      'limit': limit,
      'search': query,
      'isActive': status,
    });
  }

  static String deleteGroup(String id) => 'group/delete/$id';

  // users
  static String userDetails(String id) => 'user/get/$id';
  static const updateUser = 'user/update';
  static String usersDropdown({String? roleFilter}) =>
      _buildUrl('user/dropdown', {'roleFilter': roleFilter});

  static String users({
    int page = 1,
    int? limit,
    String? query,
    bool? isVerified,
    bool? isDeleted,
    String? roleFilter,
    String? groupFilter,
  }) {
    return _buildUrl('user/get', {
      'page': page,
      'limit': limit,
      'search': query,
      'isVerified': isVerified,
      'isDeleted': isDeleted,
      'roleFilter': roleFilter,
      'groupFilter': groupFilter,
    });
  }

  // Batches
  static String batches({
    int page = 1,
    int? limit,
    String? query,
    String? groupId,
  }) {
    return _buildUrl('batch/get', {
      'page': page,
      'limit': limit,
      'search': query,
      'groupFilter': groupId,
    });
  }

  static String dropdownBatches({String? query}) =>
      _buildUrl('batch/dropdown', {'search': query});

  static String createBatch() => 'batch/create';
  static String updateBatch() => 'batch/update';
  static String batchDetails(String id) => 'batch/get/$id';

  // life-light
  static String lifeLight({int page = 1, int? limit, String? query}) {
    return _buildUrl('lifeLight/get', {
      'page': page,
      'limit': limit,
      'search': query,
    });
  }

  static String deleteLifeLight(String id) => 'lifeLight/delete/$id';

  // anubhuti
  static String anubhuti({int page = 1, int? limit, String? query}) {
    return _buildUrl('anubhuti/get', {
      'page': page,
      'limit': limit,
      'search': query,
    });
  }

  // alumni
  static String alumni({int page = 1, int? limit, String? query}) {
    return _buildUrl('user/get', {
      'page': page,
      'limit': limit,
      'search': query,
    });
  }

  // feedback
  static String feedback({int page = 1, int? limit, String? query}) {
    return _buildUrl('feedback/get', {
      'page': page,
      'limit': limit,
      'search': query,
    });
  }

  // delete
  static String deleteBatch(String id) => 'batch/delete/$id';
  static String deleteUser(String id) => 'user/delete/$id';

  // settings
  static String settings = 'setting/get';
  static String updateSettings = 'setting/add-update';

  // legality
  static String legality(String type) =>
      _buildUrl('legality/get', {'type': type});
  static String updateLegality = 'legality/add-update';

  //location
  static String locations({
    int page = 1,
    int? limit,
    String? query,
    String? type,
    String? status,
  }) {
    return _buildUrl('location/get', {
      'page': page,
      'limit': limit,
      'search': query,
      'typeFilter': type,
      'isActive': status == 'Active' ? true : (status == null ? null : false),
    });
  }

  static String locationsDropdown({
    String? query,
    String? type,
    String? status,
  }) {
    return _buildUrl('location/dropdown', {
      'search': query,
      'typeFilter': type,
      'isActive': status == 'Active' ? true : (status == null ? null : false),
    });
  }

  static String locationDetails(String id) => 'location/get/$id';
  static String deleteLocation(String id) => 'location/delete/$id';
  static String updateLocation() => 'location/update';
  static String createLocation() => 'location/add';
  static String dropdownLocation({String? query}) =>
      _buildUrl('location/dropdown', {'search': query});

  //branches
  static String branches({int page = 1, int? limit, String? query}) {
    return _buildUrl('branch/get', {
      'page': page,
      'limit': limit,
      'search': query,
    });
  }

  static String branchDetails(String id) => 'branch/get/$id';
  static String deleteBranch(String id) => 'branch/delete/$id';
  static String updateBranch() => 'branch/update';
  static String createBranch() => 'branch/add';
  static String dropdownBranch({String? query}) =>
      _buildUrl('branch/dropdown', {'search': query});

  // forgot password
  static String forgotPassword = '/auth/forgot-password';

  // programs
  static String programs({int page = 1, int? limit, String? query}) {
    return _buildUrl('program/get', {
      'page': page,
      'limit': limit,
      'search': query,
    });
  }

  static String deleteProgram(String id) => 'program/$id';
  static String updateProgram() => 'program/update';
  static String createProgram() => 'program/create';
  static String programDetails(String id) => 'program/$id';

  //attendence
  static String attendances({
    int page = 1,
    int? limit,
    String? query,
    String? programId,
  }) {
    return _buildUrl('attendance/get', {
      'page': page,
      'limit': limit,
      'search': query,
      'programId': programId,
    });
  }

  static String updateAttendance(String id) => 'attendance/update/$id';
}
