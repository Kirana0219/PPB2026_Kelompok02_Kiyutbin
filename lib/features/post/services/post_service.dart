import 'package:kiyutbin_mobile/core/config/database.dart';
import 'package:kiyutbin_mobile/features/post/model/post_model.dart';

class PostService {
  Future<List<PostModel>> getPosts() async {
    final response = await Database.client
        .from('posts')
        .select()
        .order('created_at', ascending: false);

    return response
        .map<PostModel>((item) => PostModel.fromMap(item))
        .toList();
  }
}