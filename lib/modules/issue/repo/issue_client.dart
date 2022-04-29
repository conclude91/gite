import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../github/github_module.dart';
import '../issue_module.dart';

class IssueClient {
  IssueClient({
    http.Client? httpClient,
    this.baseUrl = IssueApi.fetchUrl,
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  Future<IssueResult> search(
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
      return IssueResult.fromJson(results);
    } else {
      throw IssueError.fromJson(results);
    }
  }
}
