class UserError {
  const UserError({required this.message});

  final String message;

  static UserError fromJson(dynamic json) {
    return UserError(
      message: json['message'] as String,
    );
  }
}
