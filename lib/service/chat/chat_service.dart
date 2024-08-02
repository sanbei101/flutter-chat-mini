import 'package:flutterchat/models/message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatService {
  // 获取Supabase客户端实例
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  //获取用户流列表
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _supabaseClient
        .from('profiles')
        .stream(primaryKey: ['id']).map((snapshot) {
      return snapshot.map((user) {
        return {
          'email': user['email'],
          'id': user['id'],
        };
      }).toList();
    });
  }

// 获取消息流列表
  Stream<List<Map<String, dynamic>>> getMessagesStream(
      String senderEmail, String receiverEmail) {
    return _supabaseClient
        .from('chat_message')
        .stream(primaryKey: ['timeStamp'])
        .eq('receiverEmail', receiverEmail)
        .order('time_stamp', ascending: false) // 按时间戳降序排列消息
        .map((snapshot) {
          return snapshot.map((message) {
            return {
              'senderEmail': message['senderEmail'],
              'receiverEmail': message['receiverEmail'],
              'message': message['message'],
              'timeStamp': message['timeStamp'],
            };
          }).toList();
        });
  }

  // 发送消息
  Future<void> sendMessage(String receiveEmail, String message) async {
    // 获取当前用户信息
    final currentUserEmail = _supabaseClient.auth.currentUser!.email!;
    final DateTime timeStamp = DateTime.now();

    // 创建消息
    Message newMessage = Message(
      senderEmail: currentUserEmail,
      receiverEmail: receiveEmail,
      message: message,
      timeStamp: timeStamp,
    );
    // 插入消息到 Supabase 的 chat_message 表
    final response =
        await _supabaseClient.from('chat_message').insert(newMessage.toMap());

    if (response.error != null) {
      // 处理插入消息时的错误
    }
  }
}
