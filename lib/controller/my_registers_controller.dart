import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_ceclimar/models/register_response.dart';

class MyRegistersController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RegisterResponse>> getRegisters() async {
    User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado');
    }

    QuerySnapshot registerSnapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('registers')
        .get();

    List<RegisterResponse> registers = registerSnapshot.docs.map((doc) {
      return RegisterResponse.fromJson({
        ...doc.data() as Map<String, dynamic>, 
        'id': doc.id,
      });
    }).toList();

    return registers;
  }
}