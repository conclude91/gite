import 'dart:async';

import '../user_module.dart';

class UserRepository {
  const UserRepository(this.cache, this.client);

  final UserCache cache;
  final UserClient client;

  Future<UserResult> search(String query) async {
    final cachedResult = cache.get(query);
    if (cachedResult != null) {
      return cachedResult;
    }
    final result = await client.search(query);
    cache.set(query, result);
    return result;
  }
}
