import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alh/adminInterface/models/models.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Orders>> getOrders() {
    return _firebaseFirestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Orders.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Orders>> getPendingOrders() {
    return _firebaseFirestore
        .collection('orders')
        .where('isDelivered', isEqualTo: false)
        .where('isCancelled', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Orders.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Product>> getProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addProduct(Product product) {
    return _firebaseFirestore.collection('products').add(product.toMap());
  }

  Future<void> updateField(
    Product product,
    String field,
    dynamic newValue,
  ) {
    return _firebaseFirestore
        .collection('products')
        .where('id', isEqualTo: product.id)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.first.reference.update({field: newValue}));
  }

  Future<void> updateOrder(
    Orders order,
    String field,
    dynamic newValue,
  ) {
    return _firebaseFirestore
        .collection('orders')
        .where('id', isEqualTo: order.id)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.first.reference.update({field: newValue}));
  }
}
