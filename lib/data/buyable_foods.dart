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

Map<String, dynamic> buyableFoods = {
  // cheese
  'Cheese': {
    'id': 'f32b9c9c-2685-4e47-a81a-b07e83d101d8',
    'name': 'Cheese',
    'description':
        'Cheese is a dairy product, derived from milk and produced in wide ranges of flavors, textures and forms by coagulation of the milk protein casein. It comprises proteins and fat from milk, usually the milk of cows, buffalo, goats, or sheep. During production, the milk is usually acidified and the enzymes of rennet (or bacterial enzymes with similar activity) are added to cause the milk proteins (casein) to coagulate. The solids (curd) are separated from the liquid (whey) and pressed into final form. Some cheeses have aromatic molds on the rind, the outer layer, or throughout. Most cheeses melt at cooking temperature.',
    'image':
        'https://www.gazzettadellevalli.it/gdv/wp-content/uploads/2020/06/Sagra-dei-Cals%C3%B9-Vione.jpg',
    'price': 5.0,
    'owner': 'Ristorante Bella Tavola - Via Nazionale delle Dolomiti, 15',
  },
  // milk
  'Milk': {
    'id': 'f14595af-4b52-4b00-85c0-0237f15d4a4f',
    'name': 'Milk',
    'description': '',
    'image':
        'https://i.pinimg.com/736x/93/d1/f6/93d1f6191cc2a758c3212b6d2e088705.jpg',
    'price': 1.0,
    'owner': 'Agriturismo Nel Bosco - Località Foresta',
  },
  // bretzel
  'Bretzel': {
    'id': 'f14595af-4b52-4b00-85c0-0237f15d4a4f',
    'name': 'Bretzel',
    'description': '',
    'image':
        'https://i.pinimg.com/736x/93/d1/f6/93d1f6191cc2a758c3212b6d2e088705.jpg',
    'price': 1.0,
    'owner': 'Panificio La Dolce Vita - Via Nazionale delle Dolomiti, 21',
  },
};
