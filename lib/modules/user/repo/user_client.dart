import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../github/github_module.dart';
import '../user_module.dart';

class UserClient {
  UserClient({
    http.Client? httpClient,
    this.baseUrl = UserApi.fetchUrl,
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  Future<UserResult> search(
    String query,
  ) async {
    final response = await httpClient.get(
        Uri.parse(
          baseUrl + query,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'token ' + GithubCredentials.token,
        });
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return UserResult.fromJson(results);
    } else {
      throw UserError.fromJson(results);
    }
  }
}
