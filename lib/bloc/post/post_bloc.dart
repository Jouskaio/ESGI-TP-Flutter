import 'package:bloc/bloc.dart';
import 'package:esgi_tp_flutter/bloc/post/post_event.dart';
import 'package:esgi_tp_flutter/bloc/post/post_state.dart';

import '../../data/repository/posts_repository.dart';


class PostBloc extends Bloc<PostEvent, PostsState> {
  final PostsRepository repository;

  PostBloc({required this.repository}) : super(PostsState()) {
    on<GetAllPosts>((event, emit) async {
      emit(state.copyWith(status: PostStatus.loading));

      try {
        final posts = await repository.getPosts();
        emit(state.copyWith(status: PostStatus.success, posts: posts));
      } catch (error) {
        emit(state.copyWith(status: PostStatus.error, error: error.toString()));
      }
    });
  }
}