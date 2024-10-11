import 'package:dio/dio.dart';
import 'package:flutter_quote_generator/data/remote/network_service.dart';
import 'package:flutter_quote_generator/global/constants/api_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

const successMessage = {'message': 'success'};
const errorMessage = {'message': 'error'};

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);

  setUp(() {
    dio.httpClientAdapter = dioAdapter;
  });

  test('should perform a GET request and return response', () async {
    dioAdapter.onGet(
      ApiConstants.quoteBaseUrl,
      (request) => request.reply(200, successMessage),
      data: null,
      queryParameters: {},
      headers: {},
    );

    final networkService = NetworkService(dio);

    final response = await networkService.get(ApiConstants.quoteBaseUrl);

    expect(response.data, successMessage);
    expect(response.statusCode, 200);
  });

  test('should perform a POST request with data and return response', () async {
    final data = {'key': 'value'};

    dioAdapter.onPost(
      ApiConstants.quoteBaseUrl,
      (request) => request.reply(201, successMessage),
      data: data,
      queryParameters: {},
      headers: {},
    );

    final networkService = NetworkService(dio);

    final response = await networkService.post(
      ApiConstants.quoteBaseUrl,
      data: data,
    );

    expect(response.data, successMessage);
    expect(response.statusCode, 201);
  });

  test('should perform a PATCH request with data and return response',
      () async {
    final data = {'key': 'value'};

    dioAdapter.onPatch(
      ApiConstants.quoteBaseUrl,
      (request) => request.reply(200, successMessage),
      data: data,
      queryParameters: {},
      headers: {},
    );

    final networkService = NetworkService(dio);

    final response = await networkService.patch(
      ApiConstants.quoteBaseUrl,
      data: data,
    );

    expect(response.data, successMessage);
    expect(response.statusCode, 200);
  });

  test('should handle DioException gracefully on GET request', () async {
    dioAdapter.onGet(
      ApiConstants.quoteBaseUrl,
      (request) => request.throws(
        404,
        DioException(
          type: DioExceptionType.badResponse,
          message: 'Not found',
          requestOptions: RequestOptions(path: ApiConstants.quoteBaseUrl),
        ),
      ),
      queryParameters: {},
      headers: {},
    );

    final networkService = NetworkService(dio);

    expect(
      () async => await networkService.get(ApiConstants.quoteBaseUrl),
      throwsA(isA<DioException>()),
    );
  });
}
