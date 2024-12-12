import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_ceclimar/models/register_response.dart';

class PendingRegistersController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RegisterResponse>> getAllPendingRegisters() async {
    QuerySnapshot registerSnapshot = await _firestore
        .collectionGroup('registers')  
        .where('status', isEqualTo: 'Enviado')
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
