import 'package:esgi_tp_flutter/ui/pages/post_edit.dart';
import 'package:flutter/material.dart';
import '../../model/post.dart';

class PostDetails extends StatelessWidget {
  static const String routeName = '/details';

  static void navigateTo(BuildContext context, Post post) {
    Navigator.of(context).pushNamed(routeName, arguments: post);
  }

  final Post post;


  const PostDetails({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                _onEditButton(context);
              },
              icon: const Icon(Icons.edit, size: 20.0),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Text(
                post.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(post.content),
          ],
        ),
      ),
    );
  }

  void _onEditButton(BuildContext context) {
    // Implémentez la logique pour l'édition de l'élément ici
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostEdit(post: post),
      ),
    ).then((editedPost) {
      if (editedPost != null) {
        // Mettez à jour les données du post avec les nouvelles valeurs
        post.title = editedPost.title;
        post.content = editedPost.content;

        // Affichez une notification ou effectuez une autre action après la modification
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Post updated successfully'),
          ),
        );
      }
    });
  }
}
