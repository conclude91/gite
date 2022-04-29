import 'dart:async';

import '../issue_module.dart';

class IssueRepository {
  const IssueRepository(this.cache, this.client);

  final IssueCache cache;
  final IssueClient client;

  Future<IssueResult> search(String query) async {
    final cachedResult = cache.get(query);
    if (cachedResult != null) {
      return cachedResult;
    }
    final result = await client.search(query);
    cache.set(query, result);
    return result;
  }
}
