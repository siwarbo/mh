import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final String email;
  final String role;

  Role({
    required this.email,
    required this.role,
  });

  @override
  List<Object?> get props {
    return [
      email,
      role,
    ];
  }

  Role copyWith({
    String? email,
    String? role,
  }) {
    return Role(
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role,
    };
  }

  factory Role.fromSnapshot(DocumentSnapshot snap) {
    return Role(
      email: snap['email'],
      role: snap['role'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;
}
