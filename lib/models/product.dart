class Product {
  final String id;
  final String name;
  final String brand;
  final String category;
  final double price;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final String description;
  final Map<String, String> specifications;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    this.rating = 4.5,
    this.reviewsCount = 12,
    required this.imageUrl,
    required this.description,
    required this.specifications,
    this.isFavorite = false,
  });
}

final List<Product> demoProducts = [
  Product(
    id: '1',
    name: 'PEUGEOT - LR01',
    brand: 'Peugeot Sport',
    category: 'Road',
    price: 1999.99,
    rating: 4.9,
    reviewsCount: 128,
    imageUrl: 'assets/images/products/mikkel-bicycle.png',
    description:
        'A masterpiece of vintage aesthetics blended with modern racing technology. The LR01 features a hand-welded frame and a geometry optimized for long-distance endurance. Whether climbing mountain passes or cruising the coast, it provides a stiff yet compliant ride that absorbs road vibrations while delivering maximum power transfer.',
    specifications: {
      'Frame': '6061 Double Butted Aluminum',
      'Drivetrain': 'Shimano 105 R7000 (22 Speed)',
      'Weight': '9.2 kg',
      'Tires': 'Continental Grand Prix 700x25c',
      'Brakes': 'Shimano 105 Hydraulic Disc',
      'Warranty': 'Lifetime on Frame',
    },
  ),
  Product(
    id: '2',
    name: 'SMITH - Trade',
    brand: 'Smith Optics',
    category: 'Helmet',
    price: 180.00,
    rating: 4.7,
    reviewsCount: 85,
    imageUrl: 'assets/images/products/cobi-helmet.png',
    description:
        'Engineered for the elite cyclist, the Smith Trade helmet sets the standard for safety and aerodynamics. It features Koroyd® technology for superior impact absorption and the MIPS® Brain Protection System to reduce rotational forces. The VaporFit™ system allows for a 270-degree adjustment for a secure, custom fit.',
    specifications: {
      'Safety': 'MIPS® & Koroyd® Certified',
      'Weight': '280g',
      'Ventilation': '21 Optimized Air Vents',
      'Fit System': 'VaporFit™ Adjustable Dial',
      'Padding': 'Ionic+™ Antimicrobial Lining',
    },
  ),
  Product(
    id: '3',
    name: 'PILOT - CHROMOLY 520',
    brand: 'Pilot Cycles',
    category: 'Road',
    price: 3999.99,
    rating: 4.8,
    reviewsCount: 45,
    imageUrl: 'assets/images/products/robert-bicycle.png',
    description:
        'The Pilot Chromoly 520 is a boutique steel road bike designed for the purist. Built with legendary Reynolds 520 tubing, this bike offers a "springy" ride quality that carbon simply cannot replicate. It is the perfect blend of traditional craftsmanship and modern 12-speed electronic shifting performance.',
    specifications: {
      'Frame': 'Reynolds 520 Chromoly Steel',
      'Fork': 'Full Carbon Tapered',
      'Drivetrain': 'SRAM Rival eTap AXS',
      'Weight': '8.5 kg',
      'Wheels': 'DT Swiss ER1600 Spline',
    },
  ),
  Product(
    id: '4',
    name: 'SMITH2 - Aero',
    brand: 'Smith Optics',
    category: 'Helmet',
    price: 99.09,
    rating: 4.3,
    reviewsCount: 15,
    imageUrl: 'assets/images/products/sky-helmet.png',
    description:
        'A lightweight, entry-level performance helmet that doesn\'t compromise on safety. The Smith2 Aero features a streamlined profile to reduce drag and high-flow ports to keep your head cool during mid-day summer rides. An excellent choice for beginners and enthusiasts alike.',
    specifications: {
      'Material': 'Expanded Polystyrene (EPS)',
      'Weight': '290g',
      'Ventilation': '18 Strategic Vents',
      'Buckle': 'Magnetic Fidlock® System',
    },
  ),
  Product(
    id: '5',
    name: 'CLA - URBAN',
    brand: 'CLA Designs',
    category: 'Urban',
    price: 1500.00,
    rating: 4.4,
    reviewsCount: 92,
    imageUrl: 'assets/images/products/cla-bycycle.png',
    description:
        'The CLA Urban is built for the daily grind. Featuring a low-maintenance internal gear hub and a belt drive system, you can say goodbye to greasy chains and constant tune-ups. Its upright geometry provides excellent visibility in heavy city traffic, making it the king of the concrete jungle.',
    specifications: {
      'Frame': 'High-Tensile Steel',
      'Drive': 'Gates Carbon Belt Drive',
      'Gears': 'Shimano Alfine 8-Speed Hub',
      'Weight': '12.5 kg',
      'Extras': 'Integrated Fenders & Rack',
    },
  ),
  Product(
    id: '6',
    name: 'RED HELMET - Pro',
    brand: 'Pro Safety',
    category: 'Helmet',
    price: 150.00,
    rating: 4.6,
    reviewsCount: 210,
    imageUrl: 'assets/images/products/red-helmet.png',
    description:
        'High visibility meets high-grade protection. The Pro Vision Red Helmet is specifically designed for urban commuters who frequently ride in low-light conditions. The vibrant finish is treated with a reflective coating, and the rear features an integrated rechargeable LED light for 360-degree visibility.',
    specifications: {
      'Material': 'In-Mold Polycarbonate',
      'Weight': '310g',
      'Light': 'Integrated LED (USB-C)',
      'Visor': 'Detachable Sun Peak',
      'Cooling': 'Internal Airflow Channels',
    },
  ),
  Product(
    id: '7',
    name: 'SPECIALIZED - Turbo',
    brand: 'Specialized',
    category: 'Electric',
    price: 4500.00,
    rating: 4.8,
    reviewsCount: 56,
    imageUrl: 'assets/images/products/electric-bicycle.png',
    description:
        'The ultimate e-bike for city dwellers. The Turbo features a silent 250W motor that quadruples your effort, making hills feel flat. The integrated 530Wh battery is seamlessly locked into the frame but can be easily removed for convenient charging. Navigate your city with confidence and style.',
    specifications: {
      'Motor': 'Specialized 2.0 (250W / 70Nm)',
      'Battery': 'Specialized U2-530, 530Wh',
      'Range': 'Up to 110 km (Eco Mode)',
      'Top Speed': '25 km/h (Limited)',
      'Charging': '100% in 4.5 Hours',
    },
  ),
];