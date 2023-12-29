import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_note_app/firebase_options.dart';
import 'package:smart_note_app/screens/home.dart';
import 'models/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'screens/login_page.dart';


Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
   storeDataInFirestore();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
void storeDataInFirestore() async {
  // Référence à la collection "notes" dans Firebase Firestore
  CollectionReference notesCollection = FirebaseFirestore.instance.collection('AppNote');
    // Sauvegarde des données dans Firebase Firestore
  for (Note note in sampleNotes) {
    await notesCollection.doc(note.id.toString()).set({
      'title': note.title,
      'content': note.content,
      'modifiedTime': note.modifiedTime.toIso8601String(),
    });
  }
}

