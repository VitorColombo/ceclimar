import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_ceclimar/models/register_response.dart';

class MyProfileController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<RegisterResponse>> getRegistersStream() {
    User? user = _auth.currentUser;

    if (user == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('registers')
        .snapshots() 
        .map((snapshot) {
      List<RegisterResponse> registers = snapshot.docs.map((doc) {
        return RegisterResponse.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }).toList();
      registers.sort((a, b) => b.date.compareTo(a.date));
      return registers;
    });
  }

  Stream<Map<dynamic, dynamic>> getAnimalsCountersStream() {
    User? user = _auth.currentUser;

    if (user == null) {
      return Stream.value({});
    }

    Map<dynamic, dynamic> defaultCounters = {
      'mammalsFound': 0,
      'birdsFound': 0,
      'reptilesFound': 0,
    };

    return _firestore
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .map((userSnapshot) {
      if (userSnapshot.exists) {
        Map<dynamic, dynamic> data = userSnapshot.data() as Map<dynamic, dynamic>;
        
        defaultCounters['mammalsFound'] = data['mammalsFound'] ?? 0;
        defaultCounters['birdsFound'] = data['birdsFound'] ?? 0;
        defaultCounters['reptilesFound'] = data['reptilesFound'] ?? 0;
        return defaultCounters;
      } else {
        return defaultCounters;
      }
    });
  }
}