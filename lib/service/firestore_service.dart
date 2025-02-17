import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rpg/models/character.dart';

class FirestoreService {

  static final ref = FirebaseFirestore.instance
    .collection('characters')
    .withConverter(
      fromFirestore: Character.fromFirestore, 
      toFirestore: (Character c, _) => c.toFirestore()
    );

  // add a new character
  static Future<void> addCharacter(Character character) async {
    await ref.doc(character.id).set(character);
  }
}
