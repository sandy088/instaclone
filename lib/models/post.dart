import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;

  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  Post(
      {required this.description,
      required this.uid,
      required this.username,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profImage,
      required this.likes});

// when we call this function in user , it will automatically convert all the arguments to the objects
  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profImage": profImage,
        "likes": likes
      };

  // function to get user details from snapshot
  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        description: snapshot['description'],
        uid: snapshot['uid'],
        postUrl: snapshot['postUrl'],
        username: snapshot['username'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        profImage: snapshot['profImage'],
        likes: snapshot['likes']);
  }
}
