class RepoError {
  const RepoError({required this.message});

  final String message;

  static RepoError fromJson(dynamic json) {
    return RepoError(
      message: json['message'] as String,
    );
  }
}
