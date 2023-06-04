import 'package:esgi_tp_flutter/bloc/post/post_bloc.dart';
import 'package:esgi_tp_flutter/data/repository/posts_repository.dart';
import 'package:esgi_tp_flutter/ui/pages/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/post/post_event.dart';
import '../../bloc/post/post_state.dart';
import 'post_adding.dart';
import 'post_details.dart';
import '../../model/post.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(
        repository: RepositoryProvider.of<PostsRepository>(context),
      )..add(GetAllPosts()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Homepage'),
          ),
          body: BlocBuilder<PostBloc, PostsState>(
            builder: (context, state) {
              switch (state.status) {
                case PostStatus.initial:
                  return const SizedBox();

                case PostStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case PostStatus.error:
                  return Center(
                    child: Text(state.error),
                  );

                case PostStatus.success:
                  final posts = state.posts;

                  if (posts.isEmpty) {
                    return const Center(
                      child: Text('Why did you delete all posts ?'),
                    );
                  }

                  return
                    ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return PostItem(
                          post: post,
                          onTap: () => _postButton(context, post),
                        );
                      },
                  );
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.post_add),
            onPressed: () => _addButton(context),
          ),
        );
      }),
    );
  }

  void _addButton(BuildContext context) {
    PostAdding.navigateTo(context);
  }

  void _postButton(BuildContext context, Post post) {
    PostDetails.navigateTo(context, post);
    //navigate to add post form
  }
}
