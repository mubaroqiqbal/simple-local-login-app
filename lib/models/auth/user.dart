final String tableUsers = 'users';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, userName, password, email
  ];

  static final String id = '_id';
  static final String userName = 'userName';
  static final String email = 'email';
  static final String password = 'password';
}

class User {
  final int? id;
  final String? userName;
  final String email;
  final String password;

  const User({
    this.id,
    this.userName,
    required this.email,
    this.password = "12345",
  });

  User copy({
    int? id,
    String? userName,
    String? email,
    String? password,
  }) =>
      User(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  static User fromJson(Map<String, Object?> json) => User(
        id: json[NoteFields.id] as int?,
        userName: json[NoteFields.userName] as String,
        email: json[NoteFields.email] as String,
        password: json[NoteFields.password] as String,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.userName: userName,
        NoteFields.email: email,
        NoteFields.password: password,
      };
}
