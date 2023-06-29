class SocialFeed {
  final String name;
  final String photoURL;
  final String description;
  int likes;
  final String address;
  final String email;
  final String phone;
  final double latitude;
  final double longitude;

  SocialFeed({
    required this.name,
    required this.photoURL,
    required this.description,
    required this.likes,
    required this.address,
    required this.email,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  factory SocialFeed.fromJson(Map<String, dynamic> json) {
    return SocialFeed(
      name: json['name'] ?? '',
      photoURL: json['photoURL'] ?? '',
      description: json['description'] ?? '',
      likes: json['likes'] ?? 0,
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      latitude: json['latitude'] ?? 0,
      longitude: json['longitude'] ?? 0,
    );
  }
}