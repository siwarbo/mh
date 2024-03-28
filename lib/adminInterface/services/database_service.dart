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

  // ... existing methods ...

  Future<void> copyCheckoutToOrders() async {
    try {
      // Get the 'checkout' collection
      final checkoutCollection = _firebaseFirestore.collection('checkout');
      final ordersCollection = _firebaseFirestore.collection('orders');
      // Get all documents in the 'checkout' collection

      final checkoutDocuments = await checkoutCollection.get();
      print(
          'Number of documents in checkout: ${checkoutDocuments.docs.length}');

      // For each document in 'checkout'...
      for (final checkoutDocument in checkoutDocuments.docs) {
        // Get the data in the document
        final data = checkoutDocument.data();
        print('Data from checkout: $data'); // Print the retrieved data

        // Extract product IDs from the 'products' field

        final List<String> productIds = List<String>.from(data['products']);

        // Check if the document already exists in 'orders' collection
        final existingOrderQuery = await ordersCollection
            .where('id', isEqualTo: checkoutDocument.id)
            .get();

        if (existingOrderQuery.docs.isNotEmpty) {
          print('Document already exists in orders');
          continue; // Skip if the document already exists
        }

        // Create a new Orders object with the fields you want to copy
        final Orders newOrder = Orders(
          id: checkoutDocument.id, // You can set this to a new value if needed
          customerName: data['customerName'] ?? 'no customerName provided',
          productIds: productIds, //List<String>.from(data['products']),
          deliveryFee: data['deliveryFee'] ?? 'no deliveryFee provided',
          subtotal: data['subtotal'] ?? 'no subtotal provided',
          total: data['total'] ?? 'no total provided',
          // Assuming 'total' in orders is 'total' + 'deliveryFee' in checkout
          isAccepted: false, // Default value
          isDelivered: false, // Default value
          isCancelled: false, // Default value
        );

        // Create a new document in 'orders' with the new data
        await _firebaseFirestore.collection('orders').add(newOrder.toMap());
        print('Added a document to orders');
      }
    } catch (e) {
      print("Error copying checkout to orders: $e");
    }
  }
}
