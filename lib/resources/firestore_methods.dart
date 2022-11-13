import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instaclone/models/post.dart';
import 'package:instaclone/resources/storage_methods.dart';

class firestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String desc, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Some Error has Occured";
    try {
      String photoUrl =
          await storageMethods().uploadimageToStorage('posts', file, true);
      Post post = Post(
          description: desc,
          uid: uid,
          username: username,
          postId: ,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage);
    } catch (e) {}
  }
}
