class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.reviewCount,
  });
}

// Static Dummy Products
final List<Product> staticProducts = [
  Product(
    id: 1,
    title: 'Wireless Bluetooth Headphones',
    price: 59.99,
    description:
        'Premium wireless headphones with active noise cancellation, 30-hour battery life, and premium comfort design. Perfect for music lovers and professionals.',
    category: 'Electronics',
    image: 'https://via.placeholder.com/300?text=Wireless+Headphones',
    rating: 4.5,
    reviewCount: 1250,
  ),
  Product(
    id: 2,
    title: 'Premium Smartwatch',
    price: 199.99,
    description:
        'Advanced smartwatch with heart rate monitor, GPS tracking, and 7-day battery life. Monitor your fitness goals with precision.',
    category: 'Electronics',
    image: 'https://via.placeholder.com/300?text=Smartwatch',
    rating: 4.7,
    reviewCount: 892,
  ),
  Product(
    id: 3,
    title: '4K Webcam',
    price: 129.99,
    description:
        'Crystal clear 4K resolution webcam with auto-focus and built-in microphone. Ideal for video conferencing and streaming.',
    category: 'Electronics',
    image: 'https://via.placeholder.com/300?text=4K+Webcam',
    rating: 4.3,
    reviewCount: 567,
  ),
  Product(
    id: 4,
    title: 'Portable Power Bank',
    price: 39.99,
    description:
        'High-capacity 25000mAh power bank with fast charging support. Keep your devices charged on the go.',
    category: 'Accessories',
    image: 'https://via.placeholder.com/300?text=Power+Bank',
    rating: 4.6,
    reviewCount: 2100,
  ),
  Product(
    id: 5,
    title: 'Mechanical Keyboard',
    price: 149.99,
    description:
        'Professional mechanical keyboard with RGB lighting and programmable keys. Enhanced typing experience for gamers and professionals.',
    category: 'Electronics',
    image: 'https://via.placeholder.com/300?text=Mechanical+Keyboard',
    rating: 4.8,
    reviewCount: 1450,
  ),
  Product(
    id: 6,
    title: 'USB-C Hub',
    price: 49.99,
    description:
        'Multi-port USB-C hub with HDMI, USB 3.0, and SD card reader. Expand your laptop connectivity.',
    category: 'Accessories',
    image: 'https://via.placeholder.com/300?text=USB-C+Hub',
    rating: 4.4,
    reviewCount: 780,
  ),
  Product(
    id: 7,
    title: 'Wireless Mouse',
    price: 29.99,
    description:
        'Ergonomic wireless mouse with precision tracking and long battery life. Smooth and responsive for all your computing needs.',
    category: 'Accessories',
    image: 'https://via.placeholder.com/300?text=Wireless+Mouse',
    rating: 4.5,
    reviewCount: 1890,
  ),
  Product(
    id: 8,
    title: 'Phone Stand',
    price: 19.99,
    description:
        'Adjustable phone stand compatible with all smartphones. Perfect for video calls, streaming, and content creation.',
    category: 'Accessories',
    image: 'https://via.placeholder.com/300?text=Phone+Stand',
    rating: 4.2,
    reviewCount: 950,
  ),
];
