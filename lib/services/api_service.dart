import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/post.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String postsEndpoint = '$baseUrl/posts';

  // Check internet connectivity
  Future<bool> _hasInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // GET all posts
  Future<List<Post>> fetchPosts() async {
    try {
      if (!await _hasInternetConnection()) {
        throw Exception('No internet connection');
      }

      final response = await http.get(
        Uri.parse(postsEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  // GET single post
  Future<Post> fetchPost(int id) async {
    try {
      if (!await _hasInternetConnection()) {
        throw Exception('No internet connection');
      }

      final response = await http.get(
        Uri.parse('$postsEndpoint/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching post: $e');
    }
  }

  // CREATE new post
  Future<Post> createPost(Post post) async {
    try {
      if (!await _hasInternetConnection()) {
        throw Exception('No internet connection');
      }

      final response = await http
          .post(
            Uri.parse(postsEndpoint),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: json.encode(post.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating post: $e');
    }
  }

  // UPDATE post
  Future<Post> updatePost(Post post) async {
    try {
      if (!await _hasInternetConnection()) {
        throw Exception('No internet connection');
      }

      final response = await http
          .put(
            Uri.parse('$postsEndpoint/${post.id}'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: json.encode(post.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating post: $e');
    }
  }

  // DELETE post
  Future<bool> deletePost(int id) async {
    try {
      if (!await _hasInternetConnection()) {
        throw Exception('No internet connection');
      }

      final response = await http.delete(
        Uri.parse('$postsEndpoint/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error deleting post: $e');
    }
  }
}
