import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/storage_service.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart' show ResModel;
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

class ApiService extends GetxService {
  final http.Client _client;
  final Connectivity _connectivity;
  final GetStorage _storage;
  final String? Function() _tokenProvider;
  final VoidCallback? onUnauthorized;

  ApiService({
    http.Client? client,
    Connectivity? connectivity,
    GetStorage? storage,
    String? Function()? tokenProvider,
    this.onUnauthorized,
  }) : _client = client ?? http.Client(),
       _connectivity = connectivity ?? Connectivity(),
       _storage = storage ?? GetStorage(),
       _tokenProvider = tokenProvider ?? (() => StorageService.instance.token);

  // Singleton
  static ApiService get to => Get.find<ApiService>();

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );

  String? _getToken() => _tokenProvider();

  // BASE URL
  final String baseUrl = ApiConstants.baseUrl; // set your API base here

  // Check internet connectivity
  Future<bool> hasConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }

    if (kIsWeb) return true;

    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // GET request
  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    if (!await hasConnection()) throw Exception("No internet connection");

    headers ??= {};
    final token = _getToken();
    _logger.d("Token: $token");
    if (token != null && token.isNotEmpty) headers['Authorization'] = token;

    Uri url = Uri.parse('$baseUrl$endpoint');
    _logger.i("GET Request: $url");

    try {
      final response = await _client.get(url, headers: headers);
      return _handleResponse(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      _logger.e("GET error: $e");
      throw Exception("GET error: $e");
    }
  }

  // POST request
  Future<dynamic> post(
    String endpoint, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    if (!await hasConnection()) throw Exception("No internet connection");

    headers ??= {};
    final token = _getToken();
    if (token != null && token.isNotEmpty) headers['Authorization'] = token;

    Uri url = Uri.parse('$baseUrl$endpoint');

    _logger.i("POST Request: $url");
    log(url.toString());
    _logger.d("Body: $body");

    try {
      final response = await _client
          .post(
            url,
            headers: {'Content-Type': 'application/json', ...headers},
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception("Request timeout");
            },
          );

      return _handleResponse(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      _logger.e("POST error: $e");
      throw Exception("Something went wrong");
    }
  }

  // PUT request
  Future<dynamic> put(
    String endpoint, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    if (!await hasConnection()) throw Exception("No internet connection");

    headers ??= {};
    final token = _getToken();
    if (token != null && token.isNotEmpty) headers['Authorization'] = token;

    Uri url = Uri.parse('$baseUrl$endpoint');
    _logger.i("PUT Request: $url");
    _logger.d("Body: $body");
    try {
      final response = await _client.put(
        url,
        headers: {'Content-Type': 'application/json', ...headers},
        body: body != null ? jsonEncode(body) : null,
      );
      return _handleResponse(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      _logger.e("PUT error: $e");
      throw Exception("PUT error: $e");
    }
  }

  Future<dynamic> postMultipart(
    String endpoint, {
    Map<String, String>? fields,
    Map<String, String>? headers,
    List<http.MultipartFile>? files,
  }) async {
    if (!await hasConnection()) throw Exception("No internet connection");

    headers ??= {};
    final token = _getToken();
    if (token != null && token.isNotEmpty) headers['Authorization'] = token;

    // IMPORTANT: Flutter MultipartRequest does NOT set these by default
    headers['Accept'] = 'application/json';

    var url = Uri.parse('$baseUrl$endpoint');
    var request = http.MultipartRequest('POST', url);

    // ADD HEADERS HERE (you forgot this)
    request.headers.addAll(headers); // <-- FIX

    if (fields != null) request.fields.addAll(fields);
    if (files != null) request.files.addAll(files);

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _handleResponse(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw Exception('Multipart POST error: $e');
    }
  }

  // DELETE request
  Future<dynamic> delete(
    String endpoint, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    if (!await hasConnection()) throw Exception("No internet connection");

    headers ??= {};
    final token = _getToken();
    if (token != null && token.isNotEmpty) headers['Authorization'] = token;

    Uri url = Uri.parse('$baseUrl$endpoint');
    _logger.i("DELETE Request: $url");
    try {
      final response = await _client.delete(
        url,
        headers: {'Content-Type': 'application/json', ...headers},
        body: body != null ? jsonEncode(body) : null,
      );
      return _handleResponse(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      _logger.e("DELETE error: $e");
      throw Exception("Please try again later");
    }
  }

  // Response handler
  dynamic _handleResponse(http.Response response) {
    _logger.d(
      "Response [${response.statusCode}] from ${response.request?.url}",
    );
    _logger.v("Response Body: ${response.body}");

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final body = jsonDecode(response.body);
      return ResModel.fromJson(body);
    } else if (response.statusCode == 410) {
      _logger.w("Token expired. Clearing session.");
      if (onUnauthorized != null) {
        onUnauthorized!();
      } else {
        StorageService.instance.clearSession();
        Get.offAllNamed(AppPages.login);
      }
      throw Exception("Token expired");
    } else {
      _logger.e("API Error: ${response.statusCode} - ${response.body}");
      final body = jsonDecode(response.body);
      final resModel = ResModel.fromJson(body);
      throw ApiException(resModel.message ?? 'Unknown error');
    }
  }

  // Example for local storage with GetStorage
  void saveToStorage(String key, dynamic value) => _storage.write(key, value);

  dynamic readFromStorage(String key) => _storage.read(key);

  void removeFromStorage(String key) => _storage.remove(key);
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}
