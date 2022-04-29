import '../repo_module.dart';

class RepoResult {
  const RepoResult({
    required this.items,
    required this.totalCount,
  });

  final List<RepoModel> items;
  final int totalCount;

  static RepoResult fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .map((dynamic item) => RepoModel.fromJson(item as Map<String, dynamic>))
        .toList();
    return RepoResult(
      items: items,
      totalCount: json['total_count'],
    );
  }
}
