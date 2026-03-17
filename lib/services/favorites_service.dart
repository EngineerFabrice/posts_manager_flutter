import '../models/post.dart';

class FavoritesService {
  static final List<Post> _favorites = [];

  static List<Post> getFavorites() {
    return List.unmodifiable(_favorites);
  }

  static void addFavorite(Post post) {
    final updatedPost = post.copyWith(isFavorite: true);
    _favorites.add(updatedPost);
  }

  static void removeFavorite(int postId) {
    _favorites.removeWhere((post) => post.id == postId);
  }

  static bool isFavorite(int postId) {
    return _favorites.any((post) => post.id == postId);
  }

  static void toggleFavorite(Post post) {
    if (isFavorite(post.id!)) {
      removeFavorite(post.id!);
    } else {
      addFavorite(post);
    }
  }
}
