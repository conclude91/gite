class IssueError {
  const IssueError({required this.message});

  final String message;

  static IssueError fromJson(dynamic json) {
    return IssueError(
      message: json['message'] as String,
    );
  }
}
