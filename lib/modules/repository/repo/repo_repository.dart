import 'dart:async';

import '../repo_module.dart';

class RepoRepository {
  const RepoRepository(this.cache, this.client);

  final RepoCache cache;
  final RepoClient client;

  Future<RepoResult> search(String query) async {
    final cachedResult = cache.get(query);
    if (cachedResult != null) {
      return cachedResult;
    }
    final result = await client.search(query);
    cache.set(query, result);
    return result;
  }
}
