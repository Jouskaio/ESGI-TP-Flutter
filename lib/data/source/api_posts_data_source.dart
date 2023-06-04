import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esgi_tp_flutter/data/source/api_data_source.dart';
import 'package:uuid/uuid.dart';

import '../../model/post.dart';

class APIDataSource extends PostsDataSource {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<Post>> getPosts() async {
    QuerySnapshot querySnapshot = await firestore.collection('Post').get();
    List<Post> posts = [];

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        Post post = Post(
          id: const Uuid().v4() ,
          title: data['title'],
          author: data['author'],
          content: data['content'],
        );

        posts.add(post);
      }
    }
    return posts;
  }
}