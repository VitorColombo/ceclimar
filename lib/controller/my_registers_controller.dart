import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_ceclimar/models/register_response.dart';

class MyRegistersController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _registersCollection = FirebaseFirestore.instance.collection('registers');

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
    registers.sort((a, b) => b.date.compareTo(a.date));
    await Future.delayed(Duration(milliseconds: 500));

    return registers;
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
}