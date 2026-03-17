import '../models/post.dart';

class LocalStorageService {
  static final List<Post> _myPosts = [];

  static List<Post> getMyPosts() {
    return List.unmodifiable(_myPosts);
  }

  static void addMyPost(Post post) {
    _myPosts.add(post);
  }

  static void updateMyPost(Post updatedPost) {
    final index = _myPosts.indexWhere((p) => p.id == updatedPost.id);
    if (index != -1) {
      _myPosts[index] = updatedPost;
    }
  }

  static void deleteMyPost(int postId) {
    _myPosts.removeWhere((post) => post.id == postId);
  }

  static bool isMyPost(int postId) {
    return _myPosts.any((post) => post.id == postId);
  }
}
