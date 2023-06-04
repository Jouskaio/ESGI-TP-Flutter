import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/post.dart';
import '../widget/form/form_post_add.dart';
import 'package:uuid/uuid.dart';



class PostAdding extends StatelessWidget {
  static const String routeName = '/add';

  PostAdding({super.key});

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  late final TextEditingController titleController = TextEditingController();
  late final TextEditingController authorController = TextEditingController();
  late final TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            FormPostAddWidget(
              titleController: titleController,
              authorController: authorController,
              contentController: contentController,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _submitPost(context);
              },
              child: const Text('Post'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitPost(BuildContext context) {
    final title = titleController.text;
    final author = authorController.text;
    final content = contentController.text;

    // Get the data from the post form (you can replace it with your actual implementation)
    final post = Post(
      title: title ?? "New Post",
      author: author ?? "Weird",
      content: content ?? "Hello world",
      id: const Uuid().v4(),
    );

    // Call the function to save the post to Firebase Cloud Firestore (you need to implement this)
    savePostToFirestore(post);

    // Navigate back to the home_screen
    Navigator.pop(context);
  }

  void savePostToFirestore(Post post) {
    // Add your code here to save the post to Firestore
    // Use the Firestore API or any libraries such as Firebase SDK or FirebaseFirestore package
    FirebaseFirestore.instance.collection('Post').add(post.toMap());
  }
}
