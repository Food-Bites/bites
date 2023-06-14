class TypicalFood {
  final String id;
  final String name;
  final String image;
  final double latitude;
  final double longitude;
  final String description;

  TypicalFood({
    required this.id,
    required this.name,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.description,
  });

  factory TypicalFood.fromJson(Map<String, dynamic> json) {
    return TypicalFood(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
    );
  }
}

Map<String, dynamic> typicalFoods = {
  // Trento
  'Canederli': {
    'id': 'f32b9c9c-2685-4e47-a81a-b07e83d101d8',
    'name': 'Canederli',
    'description':
        'Canederli are bread dumplings found in the cuisine of alpine countries (Austria, Germany, Italy, Slovenia, Switzerland). They are also known as knödel, knedle, and canederli, among other names. They are made from leftover bread, which is dried and ground before being mixed with milk, eggs, and butter. The mixture is formed into balls and usually simmered or boiled. They are often served as a first course, as an accompaniment to meat dishes, or as a main course.',
    'image':
        'https://www.gazzettadellevalli.it/gdv/wp-content/uploads/2020/06/Sagra-dei-Cals%C3%B9-Vione.jpg',
    'latitude': 46.074976443080544,
    'longitude': 11.121041688190743,
  },
  // Vione
  'Tiramisu': {
    'id': 'f14595af-4b52-4b00-85c0-0237f15d4a4f',
    'name': 'Calsù',
    'description':
        'Calsù are ravioli with a tasty filling, which Vione\'s recipe wants to be made with meat, potatoes, mortadella, cheese, parsley and spices',
    'image':
        'https://i.pinimg.com/736x/93/d1/f6/93d1f6191cc2a758c3212b6d2e088705.jpg',
    'latitude': 46.24854160232554,
    'longitude': 10.445867640199626,
  },
};
