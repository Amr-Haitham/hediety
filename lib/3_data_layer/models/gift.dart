enum GiftStatus { pledged, unpledged, done }
class Gift {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final GiftStatus status;
  final String eventId;
  final String? imageUrl;

  Gift({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.status,
    required this.eventId,
    required this.imageUrl
  });

  // Convert Gift to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'status': status.index,
      'eventId': eventId,
      'imageUrl': imageUrl
    };
  }

  // Create Gift from Map
  factory Gift.fromMap(Map<String, dynamic> map) {
    return Gift(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      category: map['category'],
      price: map['price'],
      status: GiftStatus.values[map['status']],
      eventId: map['eventId'],
      imageUrl: map['imageUrl'],
    );
  }
}