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
    'image': 'https://placehold.co/600x400/orange/white',
    'latitude': 46.074976443080544,
    'longitude': 11.121041688190743,
  },
  // Vione
  'Tiramisu': {
    'id': 'f14595af-4b52-4b00-85c0-0237f15d4a4f',
    'name': 'Calsù',
    'description':
        'Calsù are ravioli with a tasty filling, which Vione\'s recipe wants to be made with meat, potatoes, mortadella, cheese, parsley and spices',
    'image': 'https://placehold.co/600x400/orange/white',
    'latitude': 46.24854160232554,
    'longitude': 10.445867640199626,
  },
  "Speck": {
    "id": "bf4eabef-7e0c-4361-8f4c-96ee2fd2c4b4",
    "name": "Speck",
    "description":
        "Speck is a type of smoked, cured ham that is popular in the Trentino Alto-Adige region. It is made from the hindquarters of the pig and has a distinct smoky flavor.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 46.4983,
    "longitude": 11.3547
  },
  "Strudel": {
    "id": "ce428977-173f-41a9-96fe-1358c10c7165",
    "name": "Strudel",
    "description":
        "Strudel is a traditional pastry filled with apples, raisins, and spices. It is a popular dessert in the Trentino Alto-Adige region and is often served with vanilla sauce.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 46.4983,
    "longitude": 11.3547
  },
  "Spätzle": {
    "id": "29b6796c-3a47-4a47-8e8b-6e40b69b10df",
    "name": "Spätzle",
    "description":
        "Spätzle are small, soft egg noodles that are commonly served as a side dish or used in various pasta dishes. They are a staple in German and Austrian cuisines, but they are also popular in the Trentino Alto-Adige region.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 46.4983,
    "longitude": 11.3547
  },
  "Gnocchi": {
    "id": "a89ff89a-1c5a-4d15-a9bc-13f9321a1d8c",
    "name": "Gnocchi",
    "description":
        "Gnocchi are soft, doughy dumplings made from potatoes, flour, and sometimes eggs. They can be served with various sauces, such as tomato sauce or pesto, and are a popular dish throughout Italy, including the Trentino Alto-Adige region.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 46.4983,
    "longitude": 11.3547
  },
  "Risotto alla Trentina": {
    "id": "dc9b2b38-6232-4d4d-8a2f-524672e56ec4",
    "name": "Risotto alla Trentina",
    "description":
        "Risotto alla Trentina is a traditional dish from the Trentino region. It is made with locally grown rice, such as Arborio or Carnaroli, and flavored with ingredients like butter, Parmesan cheese, and speck (smoked ham).",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 46.074976443080544,
    "longitude": 11.121041688190743
  },
  "Pizza Margherita": {
    "id": "f9a0f156-5c0a-4a9e-b8a7-8e2f6f2c8828",
    "name": "Pizza Margherita",
    "description":
        "Pizza Margherita is a classic Italian pizza topped with tomato sauce, mozzarella cheese, and fresh basil leaves. It was named after Queen Margherita of Italy and is a beloved dish throughout the country.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 41.9028,
    "longitude": 12.4964
  },
  "Cacio e Pepe": {
    "id": "83a43119-1a74-4f78-8c91-b4e1de5b52d5",
    "name": "Cacio e Pepe",
    "description":
        "Cacio e Pepe is a simple and delicious pasta dish from Rome. It consists of spaghetti or other long pasta tossed with grated Pecorino Romano cheese and black pepper. The cheese creates a creamy sauce when mixed with the pasta water.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 41.9028,
    "longitude": 12.4964
  },
  "Pesto Genovese": {
    "id": "d3e88e8e-86b9-4dc0-8040-6885f12b1af0",
    "name": "Pesto Genovese",
    "description":
        "Pesto Genovese is a sauce originating from Genoa, Italy. It is made with fresh basil leaves, pine nuts, garlic, Parmesan cheese, and olive oil. Pesto is typically used as a sauce for pasta dishes or as a spread on sandwiches.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 44.4075,
    "longitude": 8.9339
  },
  "Focaccia": {
    "id": "a3b9e344-89dd-47e9-a4a7-41ae62c7e999",
    "name": "Focaccia",
    "description":
        "Focaccia is a flatbread that originated in Liguria but is popular throughout Italy. It is made with olive oil, salt, and herbs, and can be topped with various ingredients like olives, onions, or cherry tomatoes. Focaccia is enjoyed as a snack or served as an accompaniment to a meal.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 44.4075,
    "longitude": 8.9339
  },
  "Lasagna": {
    "id": "2c8e3d37-4c7a-47de-8e4a-d106b47d18f2",
    "name": "Lasagna",
    "description":
        "Lasagna is a classic Italian dish made with stacked layers of pasta, meat sauce, cheese, and béchamel sauce. It is baked until golden and bubbly, resulting in a hearty and satisfying meal.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 43.7696,
    "longitude": 11.2558
  },
  "Prosciutto e Melone": {
    "id": "9b5704db-14f0-4d2b-8b5a-14e73a299ea9",
    "name": "Prosciutto e Melone",
    "description":
        "Prosciutto e Melone is a popular antipasto (appetizer) in Italy. It consists of thin slices of prosciutto, a dry-cured Italian ham, paired with ripe melon slices. The combination of sweet and savory flavors is delightful.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 41.9028,
    "longitude": 12.4964
  },

  ///
  "Burrata": {
    "id": "8e83ffde-00c2-4dbd-bc9b-b9db663fde7c",
    "name": "Burrata",
    "description":
        "Burrata is a fresh Italian cheese made from mozzarella and cream. It has a creamy interior and a firm outer shell. Burrata is often served with fresh tomatoes, basil, and a drizzle of olive oil as a delicious appetizer.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 41.9028,
    "longitude": 12.4964
  },
  "Risotto ai Funghi": {
    "id": "fc0a76e2-ee0f-4dc3-9e2f-2d58344c6604",
    "name": "Risotto ai Funghi",
    "description":
        "Risotto ai Funghi is a creamy rice dish cooked with mushrooms. It is a popular dish in Italy and showcases the rich flavors of the earthy mushrooms and the creamy risotto.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 43.7696,
    "longitude": 11.2558
  },
  "Ossobuco": {
    "id": "c0eeac59-bf24-4b0c-b3db-0383515e7c83",
    "name": "Ossobuco",
    "description":
        "Ossobuco is a traditional Milanese dish made with braised veal shanks. The shanks are slowly cooked with vegetables, white wine, and broth until tender. Ossobuco is typically served with gremolata, a mixture of lemon zest, garlic, and parsley.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 45.4642,
    "longitude": 9.1900
  },
  "Torta Caprese": {
    "id": "1a6adcf7-6d0b-4f0c-a795-f1b9fd8b02a7",
    "name": "Torta Caprese",
    "description":
        "Torta Caprese is a traditional chocolate and almond cake from the island of Capri. It is made with ground almonds, dark chocolate, butter, sugar, and eggs. The cake has a rich and moist texture and is often dusted with powdered sugar before serving.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 40.5532,
    "longitude": 14.2222
  },
  "Cannoli": {
    "id": "8ce5d53e-b36e-4a2b-8e4b-bc36f216b66f",
    "name": "Cannoli",
    "description":
        "Cannoli are traditional Sicilian pastries consisting of tube-shaped shells filled with a sweet ricotta cheese filling. The shells are crispy and can be flavored with ingredients like cocoa or pistachio. Cannoli are often garnished with powdered sugar or chocolate chips.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 37.5994,
    "longitude": 14.0154
  },
  "Polenta": {
    "id": "df9e7ff5-893e-4c80-9328-4896f90310cd",
    "name": "Polenta",
    "description":
        "Polenta is a traditional Italian dish made from ground cornmeal. It can be served as a creamy porridge or cooked until firm and then sliced and grilled. Polenta is a versatile dish that can be enjoyed on its own or served as a side dish with various toppings.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 45.4642,
    "longitude": 9.1900
  },
  "Bistecca alla Fiorentina": {
    "id": "8d6ed852-80e1-42f7-81bc-277d3ff2fb14",
    "name": "Bistecca alla Fiorentina",
    "description":
        "Bistecca alla Fiorentina is a famous Florentine steak made from the meat of the Chianina cattle breed. It is a thick-cut T-bone steak that is grilled over high heat and seasoned with salt, pepper, and olive oil. The steak is cooked rare to medium-rare to preserve its tenderness and flavor.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 43.7696,
    "longitude": 11.2558
  },
  "Carbonara": {
    "id": "bcb86077-95be-4c89-b5f2-42270e383d7e",
    "name": "Carbonara",
    "description":
        "Carbonara is a classic Italian pasta dish made with spaghetti or rigatoni, eggs, Pecorino Romano cheese, guanciale (cured pork cheek), and black pepper. The creamy sauce is created by combining the beaten eggs with the hot pasta and mixing until a velvety coating is achieved.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 41.9028,
    "longitude": 12.4964
  },
  "Cappellacci Al Ragù": {
    "id": "a68c43b2-ae5b-4b7f-b2ed-4d2bc04f47a3",
    "name": "Cappellacci Al Ragù",
    "description":
        "Cappellacci Al Ragù is a traditional pasta dish from Ferrara. Cappellacci are large, filled pasta similar to tortellini or ravioli. They are typically stuffed with a mixture of ricotta cheese, Parmesan cheese, spinach, and nutmeg. The pasta is served with a rich and savory ragù sauce made with slow-cooked meat, tomatoes, onions, carrots, and herbs.",
    "image": "cappellacci_al_ragu.jpg",
    "latitude": 44.8381,
    "longitude": 11.6198
  },
  "Tenerina": {
    "id": "2c52a605-66a4-4aef-9ea4-48efb9c50073",
    "name": "Tenerina",
    "description":
        "Tenerina is a traditional chocolate cake from Ferrara. It is named after its characteristic soft and tender texture. Tenerina is made with dark chocolate, butter, sugar, eggs, and a touch of flour. The cake has a rich and intense chocolate flavor and a slightly gooey center. It is often dusted with powdered sugar and served with whipped cream or gelato.",
    "image": "https://placehold.co/600x400/orange/white",
    "latitude": 44.8381,
    "longitude": 11.6198
  }
};
