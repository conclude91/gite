import '../user_module.dart';

class UserCache {
  final _cache = <String, UserResult>{};

  UserResult? get(String term) => _cache[term];

  void set(String term, UserResult result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}
