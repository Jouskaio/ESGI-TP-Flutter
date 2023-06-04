import '../source/api_data_source.dart';
import '../../model/post.dart';

class PostsRepository {
  final PostsDataSource postsDataSource;

  PostsRepository({
    required this.postsDataSource,
  });

  Future<List<Post>> getPosts() async {
    try {
      return await postsDataSource.getPosts();
    } catch (e) {
      rethrow;
    }
  }
}