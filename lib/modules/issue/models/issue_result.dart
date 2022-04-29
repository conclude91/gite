import '../issue_module.dart';

class IssueResult {
  const IssueResult({
    required this.items,
    required this.totalCount,
  });

  final List<IssueModel> items;
  final int totalCount;

  static IssueResult fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .map(
            (dynamic item) => IssueModel.fromJson(item as Map<String, dynamic>))
        .toList();
    return IssueResult(
      items: items,
      totalCount: json['total_count'],
    );
  }
}
