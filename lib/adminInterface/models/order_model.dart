import 'dart:convert';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Orders extends Equatable {
  final String id;
  final String customerId;
  final List<String> productIds;
  final double deliveryFee;
  final double subtotal;
  final double total;
  final bool isAccepted;
  final bool isDelivered;
  final DateTime createdAt;

  const Orders({
    required this.id,
    required this.customerId,
    required this.productIds,
    required this.deliveryFee,
    required this.subtotal,
    required this.total,
    required this.isAccepted,
    required this.isDelivered,
    required this.createdAt,
  });

  Orders copyWith({
    String? id,
    String? customerId,
    List<String>? productIds,
    double? deliveryFee,
    double? total,
    bool? isAccepted,
    bool? isDelivered,
    DateTime? createdAt,
  }) {
    return Orders(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productIds: productIds ?? this.productIds,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isDelivered: isDelivered ?? this.isDelivered,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'deliveryFee': deliveryFee,
      'subtotal': subtotal,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  // factory Order.fromSnapshot(DocumentSnapshot snap) {
  //   return Order(
  //     id: snap['id'],
  //     customerId: snap['customerId'],
  //     productIds: List<String>.from(snap['productIds']),
  //     deliveryFee: snap['deliveryFee'],
  //     subtotal: snap['subtotal'],
  //     total: snap['total'],
  //     isAccepted: snap['isAccepted'],
  //     isDelivered: snap['isDelivered'],
  //     createdAt: DateTime.fromMillisecondsSinceEpoch(snap['createdAt']),
  //   );
  // }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      customerId,
      productIds,
      deliveryFee,
      subtotal,
      total,
      isAccepted,
      isDelivered,
      createdAt,
    ];
  }

  static List<Orders> orders = [
    Orders(
      id: 'a',
      customerId: 'a',
      productIds: const ['a', 'aa'],
      deliveryFee: 10,
      subtotal: 20,
      total: 30,
      isAccepted: false,
      isDelivered: false,
      createdAt: DateTime.now(),
    ),
    Orders(
      id: 'b',
      customerId: 'b',
      productIds: const ['b', 'bb','cc'],
      deliveryFee: 10,
      subtotal: 25,
      total: 35,
      isAccepted: false,
      isDelivered: false,
      createdAt: DateTime.now(),
    ),
  ];
}
