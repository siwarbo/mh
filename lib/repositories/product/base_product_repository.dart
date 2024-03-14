import 'package:alh/models/models.dart';

abstract class BaseProductRepository {
  Stream<List<Product>> getAllProducts();
}
