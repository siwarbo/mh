import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Orders extends Equatable {
  final String id;
  //final String customerId;
  final String customerName;
  final List<String> productIds;
  final String deliveryFee;
  final String subtotal;
  final String total;
  final bool isAccepted;
  final bool isDelivered;
  final bool isCancelled;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  //final DateTime createdAt;

  Orders({
    required this.id,
    //required this.customerId,
    required this.customerName,
    required this.productIds,
    required this.deliveryFee,
    required this.subtotal,
    required this.total,
    required this.isAccepted,
    required this.isDelivered,
    required this.isCancelled,
    required this.address,
    required this.city,
    required this.country,
    required this.zipCode,
    //required this.createdAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      //customerId,
      customerName,
      productIds,
      deliveryFee,
      subtotal,
      total,
      isAccepted,
      isDelivered,
      isCancelled,
      address,
      city,
      country,
      zipCode,
      //createdAt,
    ];
  }

  Orders copyWith({
    String? id,
    //String? customerId,
    String? customerName,
    List<String>? productIds,
    String? deliveryFee,
    String? total,
    String? subtotal,
    bool? isAccepted,
    bool? isDelivered,
    bool? isCancelled,
    String? address,
    String? city,
    String? country,
    String? zipCode,
    //DateTime? createdAt,
  }) {
    return Orders(
      id: id ?? this.id,
      //customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      productIds: productIds ?? this.productIds,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isDelivered: isDelivered ?? this.isDelivered,
      isCancelled: isCancelled ?? this.isCancelled,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      //createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      //'customerId': customerId,
      'customerName': customerName,
      'productIds': productIds,
      'deliveryFee': deliveryFee,
      'subtotal': subtotal,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'isCancelled': isCancelled,
      'address' : address,
      'city': city,
      'country': country,
      'zipCode': zipCode,
      //'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Orders.fromSnapshot(DocumentSnapshot snap) {
    return Orders(
      id: snap['id'],
      //customerId: snap['customerId'],
      customerName: snap['customerName'],
      productIds: List<String>.from(snap['productIds']),
      deliveryFee: snap['deliveryFee'],
      subtotal: snap['subtotal'],
      total: snap['total'].toString(),
      isAccepted: snap['isAccepted'],
      isDelivered: snap['isDelivered'],
      isCancelled: snap['isCancelled'],
      address: snap['address'],
      city: snap['city'],
      country: snap['country'],
      zipCode: snap['zipCode'],

      //createdAt: DateTime.parse(snap['createdAt']()),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  // @override
  // List<Object> get props {
  //   return [
  //     id,
  //     customerId,
  //     productIds,
  //     deliveryFee,
  //     subtotal,
  //     total,
  //     isAccepted,
  //     isDelivered,
  //     isCancelled,
  //     createdAt,
  //   ];
  // }

  // static List<Orders> orders = [
  //   Orders(
  //     id: 'a',
      //customerId: 'a',
      // customerName: 'a',
      // productIds: const ['a', 'aa'],
      // deliveryFee: '10',
      // subtotal: '20',
      // total: '30',
      // isAccepted: false,
      // isDelivered: false,
      // isCancelled: false,
      // address: 'a',
      //createdAt: DateTime.now(),
  //   ),
  //   Orders(
  //     id: 'b',
  //     //customerId: 'b',
  //     customerName: 'b',
  //     productIds: const ['b', 'bb', 'cc'],
  //     deliveryFee: '10',
  //     subtotal: '25',
  //     total: '35',
  //     isAccepted: false,
  //     isDelivered: false,
  //     isCancelled: false,
  //     address: 'a',
  //     //createdAt: DateTime.now(),
  //   ),
  // ];
}
