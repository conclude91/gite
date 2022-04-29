import '../repo_module.dart';

class RepoCache {
  final _cache = <String, RepoResult>{};

  RepoResult? get(String term) => _cache[term];

  void set(String term, RepoResult result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}
