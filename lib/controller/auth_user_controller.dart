import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tcc_ceclimar/utils/pass_generator.dart';
import 'package:tcc_ceclimar/utils/user_role.dart';
import '../utils/firebase_auth_services.dart';
import 'package:tcc_ceclimar/models/user_data.dart';

class AuthenticationController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfController = TextEditingController();
  final TextEditingController checkPassController = TextEditingController();
  final TextEditingController profileImageController = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? userRole;
  File? _image;
  
  String? nameError;
  String? emailError;
  String? passError;
  String? passConfError;
  String? checkPassError;
  String? imageError;

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo não pode ser vazio';
    }
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (!regex.hasMatch(value)) {
      return 'O campo não deve conter caracteres especiais';
    }
    if (value.length < 3) {
      return 'O campo deve conter no mínimo 3 caracteres';
    }
    if (value.length > 40) {
      return 'O campo deve conter no máximo 50 caracteres';
    }
    if (value.split(' ').length < 2) {
      return 'O campo deve conter nome e sobrenome';
    }
    if (value.split(" ").last == '') {
      return 'O campo deve conter nome e sobrenome';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo não pode ser vazio';
    }
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha não pode ser vazia';
    }
    if (value.length < 6) {
      return 'A senha deve conter no mínimo 6 caracteres';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo não pode ser vazio';
    }
    if (value != passController.text) {
      return 'As senhas precisam ser iguais';
    }
    return null;
  }

  String? validateCheckPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha obrigatória para editar';
    }
    if (value.length < 6) {
      return 'A senha deve conter no mínimo 6 caracteres';
    }
    return null;
  }

  bool checkPassMatch() {
    return passController.text == passConfController.text;
  }

  bool validateLogin() {
    emailController.text = emailController.text.trim();
    passController.text = passController.text.trim();
    
    emailError = validateEmail(emailController.text);
    passError = validatePassword(passController.text);
    return emailError == null && passError == null;
  }

  bool validateSignIn() {
    nameController.text = nameController.text.trim();
    emailController.text = emailController.text.trim();
    passController.text = passController.text.trim();
    passConfController.text = passConfController.text.trim();

    nameError = validateName(nameController.text);
    emailError = validateEmail(emailController.text);
    passError = validatePassword(passController.text);
    passConfError = validateConfirmPassword(passConfController.text);
    return nameError == null &&
        emailError == null &&
        passError == null &&
        passConfError == null &&
        checkPassMatch();
  }

  bool validateForgotPass() {
    emailController.text = emailController.text.trim();
    emailError = validateEmail(emailController.text);
    return emailError == null && passError == null;
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    passConfController.dispose();
  }

  void clear() {
    nameController.clear();
    emailController.clear();
    passController.clear();
    passConfController.clear();
  }

  void signUpUser(BuildContext context) async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passController.text;
    try {
      User? user = await _auth.createUserWithEmailAndPassword(email, password);
    if (user != null) {
      await user.updateDisplayName(name);
      await user.reload();
      user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'profileImageUrl': '',
        'role': 'user',
      });

      Navigator.pushReplacementNamed(context, '/basePage');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuário cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'E-mail já cadastrado.';
          break;
        case 'invalid-email':
          message = 'E-mail inválido.';
          break;
        case 'weak-password':
          message = 'A senha é muito fraca.';
          break;
        default:
          message = 'Ocorreu um erro. Por favor, tente novamente.';
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  void signInUser(BuildContext context) async {
    String email = emailController.text;
    String password = passController.text;
    try {
      User? user = await _auth.signInWithEmailAndPassword(email, password);
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/basePage');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bem vindo, ${user.displayName}'), backgroundColor: Colors.green),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = 'E-mail inválido';
          break;
        case 'invalid-credential':
          message = 'Dados inválidos';
          break;
        case 'user-disabled':
          message = 'Usuário desativado';
          break;
        case 'user-not-found':
          message = 'E-mail não cadastrado';
          break;
        case 'wrong-password':
          message = 'Senha incorreta.';
          break;
        default:
          message = 'Ocorreu um erro. Por favor, tente novamente.';
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    String email = emailController.text;
    try{
      await _auth.sendPasswordResetEmail(email, context);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('Erro ao enviar email de recuperação de senha. Por favor, tente novamente.');
    }
  }

  Future<void> signInWithGoogle(context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn(
        scopes:[
          'email',
          'profile',
        ]
      ).signIn();
      if (googleSignInAccount == null) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao fazer login com Google')),
        );
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (!doc.exists) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'name': user.displayName,
            'email': user.email,
            'createdAt': FieldValue.serverTimestamp(),
            'profileImageUrl': user.photoURL,
            'role': 'user',
          });
        }

        Navigator.pushReplacementNamed(context, '/basePage');
        String name = user.displayName!;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bem vindo, $name'), backgroundColor: Colors.green,));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red,),
      );
    }
  }

  User? getCurrentUser() {
      return _auth.currentUser;
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await googleSignIn.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logout realizado com sucesso!'), backgroundColor: Colors.green,));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e"), backgroundColor: Colors.red,),
      );
    }
  }

  Future<ImageProvider> getUserImage() async {
    User? user = getCurrentUser();
    String defaultProfileImage = 'assets/images/imageProfile.png';

    if (user != null) {
      for (UserInfo userInfo in user.providerData) {
        if (userInfo.providerId == 'google.com') {
          String? photoURL = user.photoURL;
          if (photoURL != null && photoURL.startsWith('http')) {
            return NetworkImage(photoURL);
          }
        } else if (userInfo.providerId == 'password') {
            String? photoURL = await getProfileImageUrl(user.uid);
            if (photoURL == null) {
              return AssetImage(defaultProfileImage);
            }
          return NetworkImage(photoURL);
        }
      }
    }
    return AssetImage(defaultProfileImage);
  }

  Future<String?> getProfileImageUrl(String userId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (doc.exists) {
        return doc['profileImageUrl'] as String?;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  UserResponse? getUserInfo() {
    User? user = getCurrentUser();
    if (user != null) {
      return UserResponse(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        photoURL: user.photoURL,
        role: '',
      );
    }
    return null;
  }

  Future<bool> deleteAccount(String password, context) async {
    User? user = getCurrentUser();
    if (user != null) {
      try {
        if (isUserLogedWithGoogle()) {
          final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
            if (googleUser == null) {
              return false;
            }
          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          await user.reauthenticateWithCredential(credential);
          await googleSignIn.signOut();
          await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
          await user.delete();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Conta deletada com sucesso'), backgroundColor: Colors.green,));
          return true;
        } else{
          DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
          if (userDoc.exists) {
            String imageUrl = userDoc['profileImageUrl'] ?? '';
            await deleteUserImage(imageUrl);
          }
          await reauthenticateUser(user.email!, password, context);
          await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
          await user.delete();          
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Conta deletada com sucesso'), backgroundColor: Colors.green,));
          return true;
        }
      } on FirebaseAuthException catch (e) {
        String message;
        switch (e.code) {
          case 'requires-recent-login':
            message = 'O usuário precisa reautenticar antes dessa operação.';
            break;
          case 'user-not-found':
            message = 'Usuário não encontrado.';
            break;
          case 'invalid-credential':
            message = 'As credenciais fornecidas estão incorretas, malformadas ou expiraram.';
            break;
          default:
            message = 'Erro ao excluir conta: ${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
        return false;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir conta'), backgroundColor: Colors.red),
        );
        return false;
      }
    }
    return false;
  }

  Future<void> deleteUserImage(String imageUrl) async {
    try {
      if (imageUrl.isNotEmpty) {
        Reference storageReference = FirebaseStorage.instance.refFromURL(imageUrl);
        await storageReference.delete();
      }
    } catch (e) {
      throw Exception('Erro ao deletar a imagem do usuário: $e');
    }
  }

  Future<void> reauthenticateUser(String email, String password, BuildContext context) async {
    User? user = getCurrentUser();
    if (user != null) {
      try{
        AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
        await user.reauthenticateWithCredential(credential);
      } on FirebaseAuthException {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Senha inválida'),
          backgroundColor: Colors.red));
        rethrow;
      } catch (e) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro inesperado'), backgroundColor: Colors.red));
        rethrow;
      }
    }
  }

  bool isUserLogedWithGoogle() {
    User? user = getCurrentUser();
    if (user != null) {
      for (UserInfo userInfo in user.providerData) {
        if (userInfo.providerId == 'google.com') {
          return true;
        } else if (userInfo.providerId == 'password') {
          return false;
        }
      }
    }
    return false;
  }

  Future<bool> updateUserProfile(context, String password) async {
    User? user = getCurrentUser();
    bool emailChanged = emailController.text != user!.email;
    try {
      await reauthenticateUser(user.email!, password, context);
      if (passController.text.isNotEmpty) {
        await user.updatePassword(passController.text);
      }
      if (emailController.text.isNotEmpty && emailController.text != user.email) {
        await user.verifyBeforeUpdateEmail(emailController.text);
      }
      if (nameController.text.isNotEmpty && nameController.text != user.displayName) {
        await user.updateDisplayName(nameController.text);
      }
      final String? imageUrl = await _uploadImage();
      if (_image != null) {
          await _saveImageURLToFirestore(imageUrl, user.uid);
      }
      await _updateUserInFirestore(user.uid, {
        'name': nameController.text.isNotEmpty ? nameController.text : user.displayName,
        'email': emailController.text.isNotEmpty ? emailController.text : user.email,
      });

      await user.reload();
      if (emailChanged && emailController.text.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Perfil atualizado com sucesso! Verifique seu e-mail para confirmar as alterações.'),
            backgroundColor: Colors.green),
        );
        await _auth.signOut();
        Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Perfil atualizado com sucesso!'),
              backgroundColor: Colors.green),
        );
        return false;
      }
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro na operação'),
          backgroundColor: Colors.red));
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro inesperado'), backgroundColor: Colors.red));
      return false;
    }
  }

  Future<void> _updateUserInFirestore(String userId, Map<String, dynamic> userData) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        userData,
        SetOptions(merge: true),
      );
    } catch (e) {
      throw Exception('Erro ao atualizar o Firestore: $e');
    }
  }

  Future<String?> _uploadImage() async {
    if (_image == null) return null;
    User? user = getCurrentUser();
    if (user == null) return null;
    String userId = user.uid;
    final Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/$userId');
    try {
      final UploadTask uploadTask = storageRef.putFile(File(_image!.path));
      final TaskSnapshot downloadUrl = await uploadTask;
      final String url = await downloadUrl.ref.getDownloadURL();
      return url;
    } catch (e) {
        rethrow;
    }
  }

  Future<void> _saveImageURLToFirestore(String? url, String userId) async {
    if (url != null) {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'profileImageUrl': url,
      }, SetOptions(merge: true));
    }
  }

  void setImage(File? image) {
    _image = image;
  }

  bool validateEditUserForm() {
    nameController.text = nameController.text.trim();
    passController.text = passController.text.trim();
    passConfController.text = passConfController.text.trim();
    emailController.text = emailController.text.trim();
    checkPassController.text = checkPassController.text.trim();
    if (_image == null && nameController.text.isEmpty && passController.text.isEmpty && emailController.text.isEmpty) { 
      return false;
    }
    nameError = validateNameEdit(nameController.text);
    passError = validatePasswordEdit(passController.text);
    passConfError = validateConfirmPasswordEdit(passConfController.text);
    emailError = validateEmailEdit(emailController.text);
    checkPassError = validateCheckPassword(checkPassController.text);

    return nameError == null && passError == null && emailError == null && passConfError == null && checkPassError == null;
  }

  String? validateEmailEdit(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty){
      return null;
    }
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? validatePasswordEdit(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty){
      return null;
    }
    if (value.length < 6) {
      return 'A senha deve conter no mínimo 6 caracteres';
    }
    return null;
  }

  String? validateNameEdit(String value) {
    if (value.isEmpty){
      return null;
    }
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (!regex.hasMatch(value)) {
      return 'O campo não deve conter caracteres especiais';
    }
    if (value.length < 3) {
      return 'O campo deve conter no mínimo 3 caracteres';
    }
    if (value.length > 40) {
      return 'O campo deve conter no máximo 50 caracteres';
    }
    if (value.split(' ').length < 2) {
      return 'O campo deve conter nome e sobrenome';
    }
    if (value.split(" ").last == '') {
      return 'O campo deve conter nome e sobrenome';
    }
    return null;
  }

  String? validateConfirmPasswordEdit(String? value) {
    if (value != passController.text) {
      return 'As senhas precisam ser iguais';
    }
    if (value == null) {
      return null;
    }
    if (value.isEmpty){
      return null;
    }
    return null;
  }

  Future<String> getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      String role = userDoc['role'];
      userRole = role;
      return role;
    }
    return 'user';
  }

  Future<void> setRole(UserRole role, context) async {
    try {
      await checkIfUserIsAdmin(emailController.text);

      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: emailController.text)
          .get();

      if (userSnapshot.docs.length > 1) {
        throw Exception('Mais de um usuário encontrado com esse email.');
      }

      DocumentSnapshot userDoc = userSnapshot.docs.first;

      await FirebaseFirestore.instance.collection('users').doc(userDoc.id).update({
        'role': role.roleString,
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Função de pesquisador concedida!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao definir o papel do usuário: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> checkIfUserIsAdmin(String email) async {
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      var userData = userSnapshot.docs.first.data() as Map<String, dynamic>;
      UserRole userRole = roleFromString(userData['role']);

      if (userRole == UserRole.admin) {
        throw Exception('O usuário já é um pesquisador.');
      }
    }
  }

  Future<UserResponse> getLoggedUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null) {
      throw Exception('Usuário não logado');
    }
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    UserResponse userData = UserResponse.fromJson({
      ...userSnapshot.data() as Map<String, dynamic>,
      'uid': user.uid,
    });

    return userData;
  }

  Future<bool> isEmailRegistered() async {
    QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .get();

    List<UserResponse> users = usersSnapshot.docs.map((doc) {
      return UserResponse.fromJson({
        ...doc.data() as Map<String, dynamic>, 
        'id': doc.id,
      });
    }).toList();
    for (UserResponse user in users) {
      if (user.email == emailController.text) {
        return true;
      }
    }
    return false;
  }
  
  Future<bool> validateNewResearcher() async {
    nameController.text = nameController.text.trim();
    emailController.text = emailController.text.trim();

    nameError = validateName(nameController.text);
    emailError = validateEmail(emailController.text);
    return nameError == null && emailError == null && await isEmailRegistered();
  }

  Future<String> addNewResearcher(BuildContext context) async {
    String name = nameController.text;
    String email = emailController.text;
    String password = PassGenerator.generate();    
    try {
      User? user = await _auth.createUserWithEmailAndPassword(email, password);
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
          'profileImageUrl': '',
          'role': 'admin',
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pesquisador cadastrado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        return password;
      }
      return "falha";
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'E-mail já cadastrado.';
          return "email_already_exists";
        case 'invalid-email':
          message = 'E-mail inválido.';
          break;
        case 'weak-password':
          message = 'A senha é muito fraca.';
          break;
        default:
          message = 'Ocorreu um erro. Por favor, tente novamente.';
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
      return "falha";
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
      return "falha";
    }
  }
}