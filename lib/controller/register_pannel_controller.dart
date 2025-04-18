import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_ceclimar/models/register_response.dart';

class RegisterPannelController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<RegisterResponse> registers = [];

  Future<List<RegisterResponse>> getRegisterByDate(DateTime initialDate, DateTime endDate) async {
    
    DateTime initialDateTime = DateTime(initialDate.year, initialDate.month, initialDate.day, 0, 0, 0);
    DateTime endDateTime = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
    String initialDateString = initialDateTime.toIso8601String();
    String endDateString = endDateTime.toIso8601String();

    QuerySnapshot registerSnapshot = await _firestore
      .collectionGroup('registers')
      .where('date', isGreaterThanOrEqualTo: initialDateString)
      .where('date', isLessThanOrEqualTo: endDateString)
      .get();
     
    List<RegisterResponse> registers = registerSnapshot.docs.map((doc) {
        return RegisterResponse.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
      });
    }).toList();
    return registers;
  }

  Future<List<RegisterResponse>> getAllRegisters() async {
     QuerySnapshot registerSnapshot = await _firestore
        .collectionGroup('registers')
        .get();

    List<RegisterResponse> registers = registerSnapshot.docs.map((doc) {
      return RegisterResponse.fromJson({
        ...doc.data() as Map<String, dynamic>, 
        'id': doc.id,
      });
    }).toList();
    
    return registers;
  }

  Future<List<RegisterResponse>> getRegisterBySpecies(String species) async {
    QuerySnapshot registerSnapshot = await _firestore
      .collectionGroup('registers')
      .where('animal.species', isEqualTo: species)
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