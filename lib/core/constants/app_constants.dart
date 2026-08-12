abstract class ApiConstants {
  ApiConstants._();

  // Base URLs
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://fakestoreapi.com',
  );

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // ================= Endpoints =================

  // Auth
  static const String login = '/auth/login';

  // Products
  static const String products = '/products';
  static const String categories = '/products/categories';
  static const String productsByCategory = '/products/category';

  // Carts
  static const String carts = '/carts';
  static const String userCarts = '/carts/user';

  // Users
  static const String users = '/users';

  // ================= JSON Payload & Response Keys =================

  // Common Keys
  static const String keyId = 'id';

  // Auth & User Keys
  static const String keyUsername = 'username';
  static const String keyPassword = 'password';
  static const String keyEmail = 'email';
  static const String keyToken = 'token';
  static const String keyName = 'name';
  static const String keyFirstname = 'firstname';
  static const String keyLastname = 'lastname';
  static const String keyPhone = 'phone';
  static const String keyAddress = 'address';
  static const String keyCity = 'city';
  static const String keyStreet = 'street';
  static const String keyNumber = 'number';
  static const String keyZipcode = 'zipcode';

  // Product Keys
  static const String keyTitle = 'title';
  static const String keyPrice = 'price';
  static const String keyDescription = 'description';
  static const String keyCategory = 'category';
  static const String keyImage = 'image';
  static const String keyRating = 'rating';
  static const String keyRate = 'rate';
  static const String keyCount = 'count';

  // Cart Keys
  static const String keyUserId = 'userId';
  static const String keyDate = 'date';
  static const String keyProducts = 'products';
  static const String keyProductId = 'productId';
  static const String keyQuantity = 'quantity';
}