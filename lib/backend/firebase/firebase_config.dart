import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBP-zsU81F3RraQJmu9s9PqN6YUGk_tMmI",
            authDomain: "talenties-5f525.firebaseapp.com",
            projectId: "talenties-5f525",
            storageBucket: "talenties-5f525.appspot.com",
            messagingSenderId: "722863673595",
            appId: "1:722863673595:web:89e85cb6dee54b888ba05e"));
  } else {
    await Firebase.initializeApp();
  }
}
