import 'package:flutter/material.dart';
import '../models/post.dart';
import '../widgets/post_card.dart';
import '../services/favorites_service.dart';
import 'post_detail_screen.dart';
import 'create_edit_post_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Post> _favoritePosts = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    // Get favorites from your favorite service
    setState(() {
      _favoritePosts = FavoritesService.getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_favoritePosts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No Favorites Yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap the heart icon on posts to add them here',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _favoritePosts.length,
      itemBuilder: (context, index) {
        final post = _favoritePosts[index];
        return PostCard(
          post: post,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailScreen(post: post),
              ),
            ).then((_) => _loadFavorites());
          },
          onEdit: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateEditPostScreen(post: post),
              ),
            );
            if (result == true) {
              _loadFavorites();
            }
          },
          onDelete: () {
            _showDeleteDialog(post);
          },
          showFavoriteIcon: true, // You'll need to add this to PostCard
        );
      },
    );
  }

  void _showDeleteDialog(Post post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove from Favorites'),
          content: Text('Remove "${post.title}" from favorites?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                FavoritesService.removeFavorite(post.id!);
                Navigator.pop(context);
                _loadFavorites();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Removed from favorites'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}
