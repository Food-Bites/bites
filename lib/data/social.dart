class SocialFeed {
  final String name;
  final String photoURL;
  final String description;
  final int likes;
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

Map<String, dynamic> socialFeed = {
  "Ristorante Trentino": {
    "name": "Ristorante Trentino",
    "photoURL": "https://example.com/ristorante-trentino.jpg",
    "description":
        "🍽️ Traditional Trentino cuisine with a modern twist. 🍴✨ Join us for a delightful culinary journey that blends rich flavors with contemporary flair. 🌟 Like if you're craving a taste of Trentino! ❤️🇮🇹 #RistoranteTrentino #TasteOfTradition #ModernTwist",
    "likes": 432,
    "address": "Via Garibaldi 1",
    "email": "ristorante-trentino@example.com",
    "phone": "+39 123 456789",
    "latitude": 46.0679,
    "longitude": 11.1212
  },
  "Trattoria del Lago": {
    "name": "Trattoria del Lago",
    "photoURL": "https://example.com/trattoria-del-lago.jpg",
    "description":
        "🍽️ Cozy trattoria near the lake, serving homemade Italian dishes. 🍕🍝 Indulge in the authentic flavors of Italy, surrounded by the serene beauty of the lake. 🌅 Double-tap if you're a foodie who loves lakeside dining! ❤️🍷 #TrattoriaDelLago #HomemadeGoodness #LakeViews",
    "likes": 654,
    "address": "Viale dei Tigli 10",
    "email": "trattoria-del-lago@example.com",
    "phone": "+39 987 654321",
    "latitude": 46.0776,
    "longitude": 11.1201
  },
  "Osteria Trentina": {
    "name": "Osteria Trentina",
    "photoURL": "https://example.com/osteria-trentina.jpg",
    "description":
        "🍽️ Charming osteria specializing in local Trentino dishes. 🧀🍷 Immerse yourself in the authentic tastes of Trentino's culinary heritage. 🏔️❤️ Tag someone who appreciates regional cuisine! #OsteriaTrentina #LocalFlavors #CulinaryHeritage",
    "likes": 876,
    "address": "Piazza Duomo 5",
    "email": "osteria-trentina@example.com",
    "phone": "+39 345 678912",
    "latitude": 46.0683,
    "longitude": 11.1218
  },
  "Pizzeria Alpina": {
    "name": "Pizzeria Alpina",
    "photoURL": "https://example.com/pizzeria-alpina.jpg",
    "description":
        "🍕 Authentic wood-fired pizza with a breathtaking view of the Alps. 🏔️🌟 Savor the perfect combination of crispy crust, melted cheese, and stunning mountain vistas. 😍🍕 Who's up for a slice in paradise? #PizzeriaAlpina #WoodFiredPizza #AlpineViews",
    "likes": 789,
    "address": "Via Monte Bianco 12",
    "email": "pizzeria-alpina@example.com",
    "phone": "+39 567 890123",
    "latitude": 46.2534,
    "longitude": 10.4401
  },
  "Trattoria Bella Vista": {
    "name": "Trattoria Bella Vista",
    "photoURL": "https://example.com/trattoria-bella-vista.jpg",
    "description":
        "🍽️ Delicious Italian cuisine with a stunning panoramic view. 🌄🍝 Treat yourself to a memorable dining experience with mouthwatering dishes and breathtaking vistas. 🤩❤️ Tag someone you'd love to dine with here! #TrattoriaBellaVista #PanoramicDelights #ItalianFoodLove",
    "likes": 1023,
    "address": "Via Panoramica 8",
    "email": "trattoria-bella-vista@example.com",
    "phone": "+39 321 654987",
    "latitude": 46.2421,
    "longitude": 10.4498
  },
  "Osteria Rustica": {
    "name": "Osteria Rustica",
    "photoURL": "https://example.com/osteria-rustica.jpg",
    "description":
        "🍽️ Rustic osteria offering traditional dishes with a cozy atmosphere. 🏡✨ Step into a warm and inviting ambiance while savoring time-honored recipes that have stood the test of time. 🌟❤️ Like if you appreciate rustic charm and good food! #OsteriaRustica #TraditionalEats #CozyVibes",
    "likes": 567,
    "address": "Via dei Vigneti 14",
    "email": "osteria-rustica@example.com",
    "phone": "+39 876 543210",
    "latitude": 46.2512,
    "longitude": 10.4425
  },
  "Ristorante Montagna": {
    "name": "Ristorante Montagna",
    "photoURL": "https://example.com/ristorante-montagna.jpg",
    "description":
        "🍽️ Elevated dining experience with breathtaking mountain views. 🏔️✨ Indulge in refined flavors while gazing at majestic peaks that touch the sky. 😍❤️ Tag someone who would love this mountaintop feast! #RistoranteMontagna #MountainGourmet #ScenicDining",
    "likes": 987,
    "address": "Via Alpina 20",
    "email": "ristorante-montagna@example.com",
    "phone": "+39 123 456789",
    "latitude": 46.4983,
    "longitude": 11.3547
  },
  "Trattoria Alpina": {
    "name": "Trattoria Alpina",
    "photoURL": "https://example.com/trattoria-alpina.jpg",
    "description":
        "🍽️ Cozy trattoria serving traditional dishes with an alpine touch. 🏔️🍝 Discover the hearty flavors of the mountains in a charming setting that feels like a warm embrace. 🌟❤️ Double-tap if you're a fan of alpine cuisine! #TrattoriaAlpina #MountainEats #WarmHospitality",
    "likes": 654,
    "address": "Via Dolomiti 8",
    "email": "trattoria-alpina@example.com",
    "phone": "+39 987 654321",
    "latitude": 46.4983,
    "longitude": 11.3547
  },
  "Osteria Del Lago": {
    "name": "Ristorante Del Lago",
    "photoURL": "https://example.com/ristorante-del-lago.jpg",
    "description":
        "🍽️ Scenic lakeside restaurant offering fresh seafood and local specialties. 🌊🦞 Immerse yourself in a culinary journey with the finest catch of the day and regional delights. 😋❤️ Share your favorite seafood dish in the comments! #RistoranteDelLago #LakesideDining #FreshFlavors",
    "likes": 765,
    "address": "Via Lungolago 5",
    "email": "ristorante-del-lago@example.com",
    "phone": "+39 321 654987",
    "latitude": 46.4983,
    "longitude": 11.3547
  },
  "Trattoria Vista Panoramica": {
    "name": "Trattoria Vista Panoramica",
    "photoURL": "https://example.com/trattoria-vista-panoramica.jpg",
    "description":
        "🍽️ Charming trattoria with panoramic views, serving authentic Italian dishes. 🌄🍝 Delight your taste buds while enjoying breathtaking vistas that stretch as far as the eye can see. 🤩❤️ Who would you bring to this picturesque trattoria? Tag them below! #TrattoriaVistaPanoramica #AuthenticFlavors #SpectacularViews",
    "likes": 876,
    "address": "Via Panoramica 10",
    "email": "trattoria-vista-panoramica@example.com",
    "phone": "+39 567 890123",
    "latitude": 46.4983,
    "longitude": 11.3547
  },
  "Trattoria Al Castello": {
    "name": "Trattoria Al Castello",
    "photoURL": "https://example.com/trattoria-al-castello.jpg",
    "description":
        "🍽️ Quaint trattoria nestled near the castle, serving homemade Italian dishes. 🏰🍝 Step back in time and savor traditional recipes passed down through generations in an enchanting setting. 🌟❤️ Like if you love the charm of historical trattorias! #TrattoriaAlCastello #HomemadeGoodness #HistoricEats",
    "likes": 765,
    "address": "Via Castello 2",
    "email": "trattoria-al-castello@example.com",
    "phone": "+39 321 654987",
    "latitude": 46.074976443080544,
    "longitude": 11.121041688190743
  },
  "Ristorante Pantheon": {
    "name": "Ristorante Pantheon",
    "photoURL": "https://example.com/ristorante-pantheon.jpg",
    "description":
        "🍽️ Fine dining experience in the heart of the historic Pantheon square. 🏛️✨ Indulge in culinary excellence amidst the grandeur of ancient Rome. 😍❤️ Tag someone who would love to dine in this iconic location! #RistorantePantheon #LuxuryEats #HistoricAmbiance",
    "likes": 987,
    "address": "Piazza Pantheon 5",
    "email": "ristorante-pantheon@example.com",
    "phone": "+39 567 890123",
    "latitude": 41.9028,
    "longitude": 12.4964
  },
  "Trattoria dei Fiori": {
    "name": "Trattoria dei Fiori",
    "photoURL": "https://example.com/trattoria-dei-fiori.jpg",
    "description":
        "🍽️ Cozy trattoria adorned with flowers, serving homemade Italian dishes. 🌺🍝 Delight in a romantic ambiance while savoring delicious recipes made with love and care. ❤️🌟 Double-tap if you adore dining in flower-filled trattorias! #TrattoriaDeiFiori #RomanticVibes #HomemadeGoodness",
    "likes": 654,
    "address": "Via dei Fiori 10",
    "email": "trattoria-dei-fiori@example.com",
    "phone": "+39 876 543210",
    "latitude": 41.9028,
    "longitude": 12.4964
  },
  "Osteria Roma": {
    "name": "Osteria Roma",
    "photoURL": "https://example.com/osteria-roma.jpg",
    "description":
        "🍽️ Traditional osteria with a Roman twist, serving classic dishes with a modern touch. 🍷🍝 Embark on a culinary journey that pays homage to the eternal city's rich gastronomic heritage. 🌟❤️ Tag someone who dreams of exploring Rome's flavors! #OsteriaRoma #ClassicMeetsModern #RomanTradition",
    "likes": 876,
    "address": "Via Roma 20",
    "email": "osteria-roma@example.com",
    "phone": "+39 123 456789",
    "latitude": 41.9028,
    "longitude": 12.4964
  }
};
