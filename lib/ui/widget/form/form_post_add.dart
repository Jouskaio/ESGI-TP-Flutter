import 'package:flutter/material.dart';

class FormPostAddWidget extends StatefulWidget {
  final TextEditingController? titleController;
  final TextEditingController? authorController;
  final TextEditingController? contentController;
  const FormPostAddWidget({
    Key? key,
    this.titleController,
    this.authorController,
    this.contentController,
  }) : super(key: key);

  static FormPostAddState? of(BuildContext context) {
    return context.findAncestorStateOfType<FormPostAddState>();
  }

  @override
  FormPostAddState createState() => FormPostAddState();
}

class FormPostAddState extends State<FormPostAddWidget> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text('Title'),
        ),
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your post title',
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text('Author'),
        ),
        TextField(
          controller: authorController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter the author',
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text('Add content'),
        ),
        TextField(
          controller: contentController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          maxLines: null,
          minLines: null,
        ),
      ],
    );
  }
}
