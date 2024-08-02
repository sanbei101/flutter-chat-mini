import 'package:supabase_flutter/supabase_flutter.dart';

class ChatService {
  //获取Supabase客户端实例
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  //获取用户数据流
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _supabaseClient
        .from('Users')
        .stream(primaryKey: ['id']).map((snapshot) {
      //遍历每个用户数据
      return snapshot.map((doc) {
        //获取用户数据
        final user = doc;
        //返回用户数据
        return user;
      }).toList();
    });
  }
}
