class ChatUser {
  final String id;
  final String name;
  final String email;
  String? password;
  final String imageUrl;

  ChatUser({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    required this.imageUrl,
  });
}
