import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alh/deliveryPersonnelInterface/delivery_model.dart';

class DatabaseServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<DeliveryPersonnel>> getDeliveryPersonnel() {
    return _firebaseFirestore
        .collection('deliveryPersonnel')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => DeliveryPersonnel.fromSnapshot(doc))
          .toList();
    });
  }

  Stream<List<DeliveryPersonnel>> getPendingDeliveryPersonnel() {
    return _firebaseFirestore
        .collection('deliveryPersonnel')
        .where('isDelivered', isEqualTo: false)
        .where('isCancelled', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => DeliveryPersonnel.fromSnapshot(doc))
          .toList();
    });
  }

  Future<void> updateDeliveryPersonnel(
    DeliveryPersonnel deliveryPersonnel,
    String field,
    dynamic newValue,
  ) {
    return _firebaseFirestore
        .collection('deliveryPersonnel')
        .where('id', isEqualTo: deliveryPersonnel.id)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.first.reference.update({field: newValue}));
  }

  Future<void> copyOrdersToDeliveryPersonnel() async {
    try {
      // Get the 'orders' collection
      final ordersCollection = _firebaseFirestore.collection('orders');
      final deliveryPersonnelCollection =
          _firebaseFirestore.collection('deliveryPersonnel');
      // Get all documents in the 'orders' collection

      final ordersDocuments = await ordersCollection.get();
      print('Number of documents in orders: ${ordersDocuments.docs.length}');

      for (final ordersDocument in ordersDocuments.docs) {
        final data = ordersDocument.data();
        print('Data from orders: $data'); // Print the retrieved data

        // Check if the order is accepted
      if (data['isAccepted'] != true) {
        print('Order is not accepted');
        continue; // Skip if the order is not accepted
      }

        final existingDeliveryPersonnelQuery = await deliveryPersonnelCollection
            .where('id', isEqualTo: ordersDocument.id)
            .get();

        if (existingDeliveryPersonnelQuery.docs.isNotEmpty) {
          print('Document already exists in deliveryPersonnel');
          continue; // Skip if the document already exists
        }

        // Create a new DeliveryPersonnel object with the fields you want to copy
        final DeliveryPersonnel newDeliveryPersonnel = DeliveryPersonnel(
          id: ordersDocument.id, // You can set this to a new value if needed
          customerName: data['customerName'] ?? 'no customerName provided',
          productIds: List<String>.from(data['productIds']),
          deliveryFee: data['deliveryFee'] ?? 'no deliveryFee provided',
          subtotal: data['subtotal'] ?? 'no subtotal provided',
          total: data['total'] ?? 'no total provided',
          // Assuming 'total' in orders is 'total' + 'deliveryFee' in checkout
          isAccepted: data['isAccepted'] ?? false, // Default value
          isDelivered: false, // Default value
          isCancelled: false,
        );
        await _firebaseFirestore
            .collection('deliveryPersonnel')
            .add(newDeliveryPersonnel.toMap());
        print('Added a document to deliveryPersonnel');
      }
    } catch (e) {
      print("Error copying orders to deliveryPersonnel: $e");
    }
  }

  // Stream<List<DeliveryPersonnel>> getAcceptedDeliveryPersonnel() {
  //   return _firebaseFirestore
  //       .collection('deliveryPersonnel')
  //       .where('isAccepted', isEqualTo: true)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs
  //         .map((doc) => DeliveryPersonnel.fromSnapshot(doc))
  //         .toList();
  //   });
  // }
}
