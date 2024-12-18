class Friend {
  final String userId;
  final String friendId;
  final String id;

  Friend({
    required this.userId,
    required this.id,
    required this.friendId,
  });

  // Convert Friend to Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'friendId': friendId,
    };
  }

  // Create Friend from Map
  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      id: map['id'],
      userId: map['userId'],
      friendId: map['friendId'],
    );
  }
}
