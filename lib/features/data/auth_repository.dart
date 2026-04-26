import 'dart:convert';
import 'dart:io';

class AuthRepository {
  Future<Map<String, dynamic>> request({
    required String url,
    String method = 'POST',
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Set<int> successStatusCodes = const {200, 201},
  }) async {
    final uri = Uri.parse(url);
    final httpClient = HttpClient();

    try {
      final request = await httpClient.openUrl(method.toUpperCase(), uri);
      final mergedHeaders = {
        if (body != null) HttpHeaders.contentTypeHeader: 'application/json',
        ...?headers,
      };
      mergedHeaders.forEach((key, value) {
        request.headers.set(key, value);
      });

      if (body != null) {
        request.write(jsonEncode(body));
      }

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      print('response body: ${responseBody}');

      Map<String, dynamic>? decodedBody;
      if (responseBody.isNotEmpty) {
        try {
          final parsed = jsonDecode(responseBody);
          if (parsed is Map<String, dynamic>) {
            decodedBody = parsed;
          }
        } catch (_) {
          // Keep null when response is not JSON.
        }
      }

      if (successStatusCodes.contains(response.statusCode)) {
        return {
          'statusCode': response.statusCode,
          'body': decodedBody,
          'rawBody': responseBody,
        };
      }

      throw Exception(
        'Request failed [$method $url]. '
        'Status: ${response.statusCode}. Response: $responseBody',
      );
    } catch (e) {
      throw Exception('Network error: $e');
    } finally {
      httpClient.close();
    }
  }
}
