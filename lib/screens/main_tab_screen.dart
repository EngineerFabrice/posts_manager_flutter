import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'my_posts_screen.dart';
import 'create_edit_post_screen.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0;

  // Screens for each tab
  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoritesScreen(),
    const MyPostsScreen(),
  ];

  // Tab titles
  final List<String> _titles = [
    'All Posts',
    'Favorites',
    'My Posts',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
        actions: [
          if (_currentIndex == 0) // Only show refresh on All Posts tab
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                // Refresh logic
                setState(() {});
              },
              tooltip: 'Refresh',
            ),
        ],
      ),
      body: _screens[_currentIndex],

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF2563EB),
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              activeIcon: Icon(Icons.list_alt),
              label: 'All Posts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_note),
              activeIcon: Icon(Icons.edit_note),
              label: 'My Posts',
            ),
          ],
        ),
      ),

      // FAB only on All Posts tab
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateEditPostScreen(),
                  ),
                );
                if (result == true) {
                  setState(() {});
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('New Post'),
            )
          : null,
    );
  }
}
