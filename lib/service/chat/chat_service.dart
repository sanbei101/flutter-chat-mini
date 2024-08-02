import 'package:flutterchat/models/message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatService {
  // 获取Supabase客户端实例
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // 获取用户数据流
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _supabaseClient
        .from('Users')
        .stream(primaryKey: ['id']).map((snapshot) {
      // 遍历每个用户数据
      return snapshot.map((doc) {
        // 获取用户数据
        final user = doc;
        // 返回用户数据
        return user;
      }).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _supabaseClient
        .from('users')
        .stream(primaryKey: ['id']).map((snapshot) {
      return snapshot.map((doc) {
        return {
          'email': doc['email'],
          'id': doc['id'],
        };
      }).toList();
    });
  }

  // 发送消息
  Future<void> sendMessage(String receiveID, message) async {
    // 获取当前用户信息
    final currentUserId = _supabaseClient.auth.currentUser!.id;
    final currentUserEmail = _supabaseClient.auth.currentUser!.email;
    final DateTime timeStamp = DateTime.now();

    if (currentUserEmail == null) {
      // 处理用户未登录或邮箱为空的情况
      return;
    }

    // 创建消息
    // ignore: unused_local_variable
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiveID,
      message: message,
      timeStamp: timeStamp,
    );
  }
}
