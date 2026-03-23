class ApiConstants {
  static const baseUrl = 'http://localhost:5000/';

  static const login = 'auth/login';

  // groups
  static String groupsDropdown(String query) => 'group/dropdown?search=$query';
  static const createGroup = 'group/create';
  static const updateGroup = 'group/update';
  static String groupDetails(String id) => 'group/get/$id';
  static String groups({
    int page = 1,
    int? limit,
    String? query,
    bool? status,
  }) {
    String url = 'group/get?page=$page';
    if (limit != null && limit.toString().isNotEmpty) {
      url += '&limit=$limit';
    }
    if (query != null && query.isNotEmpty) {
      url += '&search=$query';
    }
    if (status != null && status.toString().isNotEmpty) {
      url += '&isActive=$status';
    }
    return url;
  }

  static String deleteGroup(String id) => 'group/delete/$id';

  // users
  static String userDetails(String id) => 'user/get/$id';
  static const updateUser = 'user/update';
  static String usersDropdown({String? roleFilter}) {
    String url = 'user/dropdown';
    if (roleFilter != null && roleFilter.isNotEmpty) {
      url += '?roleFilter=$roleFilter';
    }

    return url;
  }

  static String users({
    int page = 1,
    int? limit,
    String? query,
    bool? isVerified,
    bool? isDeleted,
    String? roleFilter,
    String? groupFilter,
  }) {
    String url = 'user/get?page=$page';
    if (limit != null && limit.toString().isNotEmpty) {
      url += '&limit=$limit';
    }
    if (query != null && query.isNotEmpty) {
      url += '&search=$query';
    }
    if (isVerified != null && isVerified.toString().isNotEmpty) {
      url += '&isVerified=$isVerified';
    }
    if (isDeleted != null && isDeleted.toString().isNotEmpty) {
      url += '&isDeleted=$isDeleted';
    }
    if (roleFilter != null && roleFilter.isNotEmpty) {
      url += '&roleFilter=$roleFilter';
    }
    if (groupFilter != null && groupFilter.isNotEmpty) {
      url += '&groupFilter=$groupFilter';
    }
    return url;
  }

  // Batches
  static String batches({
    int page = 1,
    int? limit,
    String? query,
    String? groupId,
  }) {
    String url = 'batch/get?page=$page';
    if (limit != null && limit.toString().isNotEmpty) {
      url += '&limit=$limit';
    }
    if (query != null && query.isNotEmpty) {
      url += '&search=$query';
    }
    if (groupId != null && groupId.isNotEmpty) {
      url += '&groupFilter=$groupId';
    }
    return url;
  }

  static String dropdownBatches({String? query}) {
    String url = 'batch/dropdown';
    if (query != null && query.isNotEmpty) {
      url += '?search=$query';
    }
    return url;
  }

  static String createBatch() => 'batch/create';
  static String updateBatch() => 'batch/update';
  static String batchDetails(String id) => 'batch/get/$id';

  // life-light
  static String lifeLight({int page = 1, int? limit, String? query}) {
    String url = 'lifeLight/get?page=$page';
    if (limit != null && limit.toString().isNotEmpty) {
      url += '&limit=$limit';
    }
    if (query != null && query.isNotEmpty) {
      url += '&search=$query';
    }
    return url;
  }

  static String deleteLifeLight(String id) => 'lifeLight/delete/$id';

  // anubhuti
  static String anubhuti({int page = 1, int? limit, String? query}) {
    String url = 'anubhuti/get?page=$page';
    if (limit != null && limit.toString().isNotEmpty) {
      url += '&limit=$limit';
    }
    if (query != null && query.isNotEmpty) {
      url += '&search=$query';
    }
    return url;
  }

  // alumni
  static String alumni({int page = 1, int? limit, String? query}) {
    String url = 'user/get?page=$page';
    if (limit != null && limit.toString().isNotEmpty) {
      url += '&limit=$limit';
    }
    if (query != null && query.isNotEmpty) {
      url += '&search=$query';
    }
    return url;
  }

  // feedback
  static String feedback({int page = 1, int? limit, String? query}) {
    String url = 'feedback/get?page=$page';
    if (limit != null && limit.toString().isNotEmpty) {
      url += '&limit=$limit';
    }
    if (query != null && query.isNotEmpty) {
      url += '&search=$query';
    }
    return url;
  }

  // delete
  static String deleteBatch(String id) => 'batch/delete/$id';
  static String deleteUser(String id) => 'user/delete/$id';

  // settings
  static String settings = 'setting/get';
  static String updateSettings = 'setting/add-update';

  // legality
  static String legality(String type) => 'legality/get?type=$type';
  static String updateLegality = 'legality/add-update';

  //location
  static String locations({int page = 1, int? limit, String? query}) {
    String url = 'location/get?page=$page';
    if (limit != null && limit.toString().isNotEmpty) {
      url += '&limit=$limit';
    }
    if (query != null && query.isNotEmpty) {
      url += '&search=$query';
    }
    return url;
  }

  static String deleteLocation(String id) => 'location/delete/$id';
  static String updateLocation() => 'location/update';
  static String createLocation() => 'location/add';
  static String dropdownLocation({String? query}) {
    String url = 'location/dropdown';
    if (query != null && query.isNotEmpty) {
      url += '?search=$query';
    }
    return url;
  }

  //branches
  static String branches({int page = 1, int? limit, String? query}) {
    String url = 'branch/get?page=$page';
    if (limit != null && limit.toString().isNotEmpty) {
      url += '&limit=$limit';
    }
    if (query != null && query.isNotEmpty) {
      url += '&search=$query';
    }
    return url;
  }

  static String deleteBranch(String id) => 'branch/delete/$id';
  static String updateBranch() => 'branch/update';
  static String createBranch() => 'branch/add';
  static String dropdownBranch({String? query}) {
    String url = 'branch/dropdown';
    if (query != null && query.isNotEmpty) {
      url += '?search=$query';
    }
    return url;
  }
}
