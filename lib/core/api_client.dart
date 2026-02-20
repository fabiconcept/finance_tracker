import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'constants.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  String _getErrorMessage(dynamic error, int statusCode) {
    if (statusCode == 404) {
      return 'Resource not found';
    } else if (statusCode == 400) {
      return 'Invalid request. Please check your input.';
    } else if (statusCode == 500) {
      return 'Server error. Please try again later.';
    } else if (statusCode >= 500) {
      return 'Server is unavailable. Please try again later.';
    }
    
    try {
      if (error is Map && error.containsKey('error')) {
        return error['error'].toString();
      }
      if (error is Map && error.containsKey('message')) {
        return error['message'].toString();
      }
    } catch (_) {}
    
    return 'Something went wrong. Please try again.';
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await _client.get(
        Uri.parse('$kBaseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final error = json.decode(response.body);
        throw ApiException(
          _getErrorMessage(error, response.statusCode),
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection. Please check your network.');
    } on FormatException {
      throw ApiException('Invalid response from server.');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Unable to connect to server. Please try again.');
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        final error = json.decode(response.body);
        throw ApiException(
          _getErrorMessage(error, response.statusCode),
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection. Please check your network.');
    } on FormatException {
      throw ApiException('Invalid response from server.');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Unable to connect to server. Please try again.');
    }
  }

  Future<Map<String, dynamic>> patch(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _client.patch(
        Uri.parse('$kBaseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final error = json.decode(response.body);
        throw ApiException(
          _getErrorMessage(error, response.statusCode),
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection. Please check your network.');
    } on FormatException {
      throw ApiException('Invalid response from server.');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Unable to connect to server. Please try again.');
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await _client.delete(
        Uri.parse('$kBaseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final error = json.decode(response.body);
        throw ApiException(
          _getErrorMessage(error, response.statusCode),
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection. Please check your network.');
    } on FormatException {
      throw ApiException('Invalid response from server.');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Unable to connect to server. Please try again.');
    }
  }
}
