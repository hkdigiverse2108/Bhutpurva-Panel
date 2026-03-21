import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MockClient extends Mock implements http.Client {}

class MockGetStorage extends Mock implements GetStorage {}

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ApiService apiService;
  late MockClient mockClient;
  late MockConnectivity mockConnectivity;
  late MockGetStorage mockGetStorage;
  bool onUnauthorizedCalled = false;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockClient = MockClient();
    mockConnectivity = MockConnectivity();
    mockGetStorage = MockGetStorage();
    onUnauthorizedCalled = false;

    apiService = ApiService(
      client: mockClient,
      connectivity: mockConnectivity,
      storage: mockGetStorage,
      tokenProvider: () => 'mock-token',
      onUnauthorized: () {
        onUnauthorizedCalled = true;
      },
    );

    // Default: has connection
    when(
      () => mockConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);
  });

  group('ApiService GET Tests', () {
    test('returns ResModel on success (200)', () async {
      final responseBody =
          '{"status": 200, "message": "Success", "data": {"key": "value"}}';
      when(
        () => mockClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(responseBody, 200));

      final result = await apiService.get('/test-endpoint');

      expect(result, isA<ResModel>());
      expect(result.status, 200);
    });

    test('throws Exception on 410 (Token Expired)', () async {
      when(
        () => mockClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer(
        (_) async =>
            http.Response('{"status": 410, "message": "Expired"}', 410),
      );

      await expectLater(
        () => apiService.get('/test-endpoint'),
        throwsA(isA<Exception>()),
      );
      expect(onUnauthorizedCalled, isTrue);
    });
    group('POST Tests', () {
      test('returns ResModel on success (200)', () async {
        final responseBody = '{"status": 200, "message": "Posted", "data": {}}';
        when(
          () => mockClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response(responseBody, 200));

        final result = await apiService.post('/test', body: {"test": "data"});
        expect(result.status, 200);
      });
    });

    group('PUT Tests', () {
      test('returns ResModel on success (200)', () async {
        final responseBody =
            '{"status": 200, "message": "Updated", "data": {}}';
        when(
          () => mockClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response(responseBody, 200));

        final result = await apiService.put('/test', body: {"test": "data"});
        expect(result.status, 200);
      });
    });

    group('DELETE Tests', () {
      test('returns ResModel on success (200)', () async {
        final responseBody =
            '{"status": 200, "message": "Deleted", "data": {}}';
        when(
          () => mockClient.delete(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response(responseBody, 200));

        final result = await apiService.delete('/test', body: {"id": 1});
        expect(result.status, 200);
      });
    });

    group('Connectivity Tests', () {
      test('throws Exception when no internet', () async {
        when(
          () => mockConnectivity.checkConnectivity(),
        ).thenAnswer((_) async => [ConnectivityResult.none]);

        expect(
          () => apiService.get('/test'),
          throwsA(
            predicate((e) => e.toString().contains("No internet connection")),
          ),
        );
      });
    });
  });
}
