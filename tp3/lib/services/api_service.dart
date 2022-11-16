import 'dart:convert';
import 'dart:developer';
// import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/models/comment.dart';
import 'package:tp3/models/post.dart';
import 'package:tp3/models/user.dart';
import 'package:tp3/utils/maybe.dart';

class ApiService {
  var client = locator<http.Client>();
  static const endpoint = 'https://jsonplaceholder.typicode.com';
  static const revolvair = 'https://test.revolvair.org/api';
  static const Map<String,String> headers = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
  };

  Future<MayBe<User>> getUserProfile(String email, String password) async {
    var body = json.encode({"email": email, "password": password});
    
    var response = await client.post(Uri.parse('$revolvair/login'), body: body, headers: headers);
    log(response.statusCode.toString());
    log(response.body.toString());
    log(response.request.toString());

    if (response.statusCode == 404) {
      return MayBe.empty();
    }
    else if (response.statusCode == 422) {
      return MayBe.empty();
    }

    final user = User.fromJson(response.body);
    log(user.toString());
    return MayBe(user);
  }

  Future<MayBe<User>> createUserProfile(String name, String email, String password) async {
    var body = json.encode({"name": name, "email": email, "password": password});

    var response = await client.post(Uri.parse('$revolvair/register'), body: body, headers: headers);
    log(response.statusCode.toString());
    log(response.body.toString());

    if (response.statusCode == 404) {
      return MayBe.empty();
    }
    else if (response.statusCode == 422) {
      return MayBe.empty();
    }

    final user = User.fromJson(response.body);
    log(user.toString());
    return MayBe(user);
  }

  Future<List<Post>> getPostsForUser(int userId) async {
    var posts = <Post>[];

    var response =
        await client.get(Uri.parse('$endpoint/posts?userId=$userId'));
    var parsed = jsonDecode(response.body) as List<dynamic>;
    for (var post in parsed) {
      posts.add(Post.fromMap(post));
    }

    return posts;
  }

  Future<List<Comment>> getCommentsForPost(int postId) async {
    var comments = <Comment>[];

    var response =
        await client.get(Uri.parse('$endpoint/comments?postId=$postId'));
    var parsed = json.decode(response.body) as List<dynamic>;
    for (var comment in parsed) {
      comments.add(Comment.fromMap(comment));
    }
    return comments;
  }
}
