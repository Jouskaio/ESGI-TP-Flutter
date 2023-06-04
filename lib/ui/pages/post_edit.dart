import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../model/post.dart';

class PostEdit extends StatefulWidget {
  final Post post;

  const PostEdit({Key? key, required this.post}) : super(key: key);

  @override
  _PostEditState createState() => _PostEditState();
}

class _PostEditState extends State<PostEdit> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _contentController = TextEditingController(text: widget.post.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Content',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveChanges(context);
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges(BuildContext context) {
    try {
      final updatedPost = Post(
          id: widget.post.id,
          title: _titleController.text,
          content: _contentController.text,
          author: "Thanos"
      );

      FirebaseFirestore.instance
          .collection('Post')
          .doc(widget.post.id)
          .get()
          .then((snapshot) {
        if (snapshot.exists) {
          snapshot.reference
              .update(updatedPost.toMap())
              .then((_) {
            Navigator.pop(context, updatedPost);
          }).catchError((error, stackTrace) {
            // CRASHLYTICS
            FirebaseCrashlytics.instance.recordError(error, stackTrace);
          });
        } else {
          // Document doesn't exist
          const error = 'Document does not exist';
          final stackTrace = StackTrace.current;
          FirebaseCrashlytics.instance.recordError(error, stackTrace);
          // Handle the case accordingly (e.g., show an error message)
        }
      }).catchError((error, stackTrace) {
        // CRASHLYTICS
        FirebaseCrashlytics.instance.recordError(error, stackTrace);
      });
    } catch (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);

      print('Form submission error: $error');
      print('Stack trace: $stackTrace');
    }

  }

}
