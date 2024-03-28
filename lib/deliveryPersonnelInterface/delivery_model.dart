import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class DeliveryPersonnel extends Equatable {
  final String id;
  final String customerName;
  final List<String> productIds;
  final String deliveryFee;
  final String subtotal;
  final String total;
  final bool isAccepted;
  final bool isDelivered;
  final bool isCancelled;


  DeliveryPersonnel({
     required this.id,
    required this.customerName,
    required this.productIds,
    required this.deliveryFee,
    required this.subtotal,
    required this.total,
    required this.isAccepted,
    required this.isDelivered,
    required this.isCancelled,
  });

  @override
  List<Object?> get props {
    return [
      id,
      customerName,
      productIds,
      deliveryFee,
      subtotal,
      total,
      isAccepted,
      isDelivered,
      isCancelled,
    ];
  }

  DeliveryPersonnel copyWith({
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
  }) {
    return DeliveryPersonnel(
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'productIds': productIds,
      'deliveryFee': deliveryFee,
      'subtotal': subtotal,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'isCancelled': isCancelled,
    };
  }

  factory DeliveryPersonnel.fromSnapshot(DocumentSnapshot snap) {
    return DeliveryPersonnel(
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
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;
}
