import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_ceclimar/models/register_response.dart';

class MyProfileController {
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
    registers.sort((a, b) => b.date.compareTo(a.date));
    await Future.delayed(Duration(milliseconds: 100));
    
    return registers;
  }

  Future<Map<dynamic, dynamic>> getAnimalsCounters() async{
    Map <String, int> animalsCounters = {
      'mammalsFound': 0,
      'birdsFound': 0,
      'reptilesFound': 0,
    };

    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception('Usuário não autenticado');
    }

    DocumentSnapshot userSnapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();
    if (userSnapshot.exists) {
      Map<dynamic, dynamic> data = userSnapshot.data() as Map<dynamic, dynamic>;
      animalsCounters['mammalsFound'] = data['mammalsFound'] ?? 0;
      animalsCounters['birdsFound'] = data['birdsFound'] ?? 0;
      animalsCounters['reptilesFound'] = data['reptilesFound'] ?? 0;
    } else {
      throw Exception('Usuário não encontrado');
    }

    return animalsCounters;
  }
}