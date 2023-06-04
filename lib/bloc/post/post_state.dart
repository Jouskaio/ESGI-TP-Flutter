
import '../../model/post.dart';

enum PostStatus {
  initial,
  loading,
  success,
  error,
}

class PostsState {
  final PostStatus status;
  final List<Post> posts;
  final String error;

  PostsState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.error = '',
  });

  PostsState copyWith({
    PostStatus? status,
    List<Post>? posts,
    String? error,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }
}