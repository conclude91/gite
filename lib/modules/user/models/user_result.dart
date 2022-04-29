import '../user_module.dart';

class UserResult {
  const UserResult({
    required this.items,
    required this.totalCount,
  });

  final List<UserModel> items;
  final int totalCount;

  static UserResult fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .map((dynamic item) => UserModel.fromJson(item as Map<String, dynamic>))
        .toList();
    return UserResult(
      items: items,
      totalCount: json['total_count'],
    );
  }
}
