class ApiConstants {
  static const baseUrl = 'http://localhost:5000/';

  static const login = 'auth/login';

  // groups
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
      url += '&status=$status';
    }
    return url;
  }

  // users
  static String users({
    int page = 1,
    int? limit,
    String? query,
    bool? isVerified,
    bool? isDeleted,
    String? roleFilter,
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
}
