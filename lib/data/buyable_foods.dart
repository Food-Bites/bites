class BuyableFood {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final String owner;

  BuyableFood({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.owner,
  });

  factory BuyableFood.fromJson(Map<String, dynamic> json) {
    return BuyableFood(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
      owner: json['owner'],
    );
  }
}

Map<String, dynamic> purchasableFood = {
  // cheese
  'Cheese': {
    'id': 'f32b9c9c-2685-4e47-a81a-b07e83d101d8',
    'name': 'Cheese',
    'description':
        'Cheese is a dairy product, derived from milk and produced in wide ranges of flavors, textures and forms by coagulation of the milk protein casein. It comprises proteins and fat from milk, usually the milk of cows, buffalo, goats, or sheep. During production, the milk is usually acidified and the enzymes of rennet (or bacterial enzymes with similar activity) are added to cause the milk proteins (casein) to coagulate. The solids (curd) are separated from the liquid (whey) and pressed into final form. Some cheeses have aromatic molds on the rind, the outer layer, or throughout. Most cheeses melt at cooking temperature.',
    'image':
        'https://raw.githubusercontent.com/Food-Bites/pictures/main/cheese.jpg',
    'price': 5.0,
    'owner': 'Ristorante Bella Tavola - Via Nazionale delle Dolomiti, 15',
  },
  // milk
  'Milk': {
    'id': 'f14595af-4b52-4b00-85c0-0237f15d4a4f',
    'name': 'Milk',
    'description': '',
    'image':
        'https://raw.githubusercontent.com/Food-Bites/pictures/main/milk.jpg',
    'price': 1.0,
    'owner': 'Agriturismo Nel Bosco - Località Foresta',
  },
  // bretzel
  'Bretzel': {
    'id': 'cf1fe85a-4c9e-49d3-b614-4de32cca3212',
    'name': 'Bretzel',
    'description': '',
    'image':
        'https://raw.githubusercontent.com/Food-Bites/pictures/main/bretzel.jpg',
    'price': 1.0,
    'owner': 'Panificio La Dolce Vita - Via Nazionale delle Dolomiti, 21',
  },
  // Chianti Classico
  'Chianti Classico': {
    'id': '7a8d3a7f-1d9f-4b68-9f6e-7a6f6d64c5bb',
    'name': 'Chianti Classico',
    'description':
        'Chianti Classico is a red wine produced in the Chianti region of Tuscany, Italy. It is made primarily from the Sangiovese grape, with other grape varieties such as Canaiolo and Colorino sometimes blended in. Chianti Classico has a medium body and is known for its tart cherry, plum, and spice flavors, as well as its high acidity and firm tannins. It pairs well with a wide variety of Italian dishes, including pasta with meat sauce, pizza, and roasted meats.',
    'image':
        'https://raw.githubusercontent.com/Food-Bites/pictures/main/chianti.png',
    'price': 25.0,
    'owner': 'Villa Toscana Winery - Via del Vino, 123',
  }
};
