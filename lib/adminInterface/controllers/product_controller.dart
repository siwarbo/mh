import 'package:alh/adminInterface/models/product_model.dart';
import 'package:alh/adminInterface/services/database_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final DatabaseService database = DatabaseService();

  //var products = <Product>[].obs;

  @override
  void onInit() {
    products.bindStream(database.getProducts());
    super.onInit();
  }

  // Define RxList<Product> to store products
  RxList<Product> products = <Product>[].obs;
  // Method to fetch products asynchronously
  void fetchProducts() async {
    try {
      // Fetch products from the database
      List<Product> productList = await database.getProducts().first;
      
      // Update products list with fetched data
      products.assignAll(productList);
    } catch (e) {
      // Handle errors
      print("Error fetching products: $e");
    }
  }

  // In ProductController
  // Future<List<Product>> getProducts() async {
  //   return database.getProducts().first;
  // }
  //

  var newProduct = {}.obs;

  get price => newProduct['price'];
  get quantity => newProduct['quantity'];
  get isRecommended => newProduct['isRecommended'];
  get isPopular => newProduct['isPopular'];

  void updateProductPrice(
    int index,
    Product product,
    double value,
  ) {
    product.price = value;
    products[index] = product;
  }

  void saveNewProductPrice(
    Product product,
    String field,
    double value,
  ) {
    database.updateField(product, field, value);
  }

  void updateProductQuantity(
    int index,
    Product product,
    int value,
  ) {
    product.quantity = value;
    products[index] = product;
  }
}
