import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velaris/UI/views/delete_confirm_login/delete_confirm_login_view.dart';
import 'package:velaris/service/auth_service.dart';
import 'package:velaris/service/firestore_service.dart';

import '../login/login_view.dart';

class DeleteAccountController {
  AuthService firebaseAuth = AuthService();
  FirestoreService firestoreService = FirestoreService();

  eliminarUsuario(BuildContext context) async {
    String uid = await firebaseAuth.eliminarUsuario(context);
    if (uid != "") {
      await firestoreService.deleteUser(uid);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
            (Route<dynamic> route) => false,
      );
    }
  }



}