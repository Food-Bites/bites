class SocialFeed {
  final String id;
  final String name;
  final String photoURL;
  final String description;
  int likes;
  final String address;
  final String email;
  final String phone;
  final double latitude;
  final double longitude;
  final List<String> foods;

  SocialFeed({
    required this.id,
    required this.name,
    required this.photoURL,
    required this.description,
    required this.likes,
    required this.address,
    required this.email,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.foods,
  });

  factory SocialFeed.fromJson(Map<String, dynamic> json) {
    final foodsList = (json['foods'] as List?)?.cast<String>() ?? [];

    return SocialFeed(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      photoURL: json['photoURL'] ?? '',
      description: json['description'] ?? '',
      likes: json['likes'] ?? 0,
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      latitude: json['latitude'] ?? 0,
      longitude: json['longitude'] ?? 0,
      foods: foodsList,
    );
  }
}
