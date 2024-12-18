class Pledge {
  String id;
  String eventId;
  String userId;
  String giftId;
  String giftOwnerId;
  bool isFulfilled;
  Pledge({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.giftId,
    required this.isFulfilled,
    required this.giftOwnerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventId': eventId,
      'userId': userId,
      'giftId': giftId,
      'giftOwnerId': giftOwnerId,
      'isFulfilled': isFulfilled,
    };
  }

  factory Pledge.fromMap(Map<String, dynamic> map) {
    return Pledge(
      id: map['id'],
      eventId: map['eventId'],
      giftOwnerId: map['giftOwnerId'],
      userId: map['userId'],
      giftId: map['giftId'],
      isFulfilled: map['isFulfilled'],
    );
  }
}
