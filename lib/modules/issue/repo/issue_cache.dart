import '../issue_module.dart';

class IssueCache {
  final _cache = <String, IssueResult>{};

  IssueResult? get(String term) => _cache[term];

  void set(String term, IssueResult result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}
