import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/utils/animals_service.dart';

class MyRegistersController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Stream<List<RegisterResponse>> getRegistersStream() {
  User? user = _auth.currentUser;

  if (user == null) {
    return Stream.value([]); // Retorna uma lista vazia se não houver usuário
  }

  return _firestore
      .collection('users')
      .doc(user.uid)
      .collection('registers')
      .snapshots() // ⬅️ Usa snapshots() para obter atualizações em tempo real (e cache)
      .map((snapshot) {
    List<RegisterResponse> registers = snapshot.docs.map((doc) {
      return RegisterResponse.fromJson({
        ...doc.data() as Map<String, dynamic>,
        'id': doc.id,
      });
    }).toList();
    // Você ainda pode ordenar aqui, se necessário
    registers.sort((a, b) => b.date.compareTo(a.date));
    return registers;
  });
}

  Stream<int> getRegistersCountStream() {
      User? user = _auth.currentUser;
        if (user == null) {
        return Stream.value(0);
      }
    
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('registers')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Future<bool> deleteRegister(String registerId, String userId) async {
    User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado');
    }

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('registers')
          .where('registerNumber', isEqualTo: registerId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('registers')
            .doc(snapshot.docs.first.id)
            .delete();
      } else {
        return false;
      }
      
      try {
        final storageRef = FirebaseStorage.instance.ref();
        await storageRef.child('registers/${registerId}_1').delete();
        await storageRef.child('registers/${registerId}_2').delete();
      } catch (e) {
        debugPrint('Error deleting images: $e');
      }
      
      return true;
    } catch (e) {
      debugPrint('Error deleting register: $e');
      return false;
    }
  }
}