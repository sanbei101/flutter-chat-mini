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
      String senderEmail, String receiverEmail) async* {
    // 调用RPC函数获取ChatRoom的ID
    try {
      final String chatRoomID = await _supabaseClient
          .rpc('get_or_create_chat_room', params: {
        'p_user1_email': senderEmail,
        'p_user2_email': receiverEmail
      });

      // 获取消息流
      yield* _supabaseClient
          .from('chat_message')
          .stream(primaryKey: ['chatRoomID'])
          .eq('chatRoomID', chatRoomID)
          .order('timeStamp', ascending: false)
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
    } catch (e) {
      throw Exception('Error occurred while getting messages stream: $e');
    }
  }

  // 发送消息
  Future<void> sendMessage(String receiverEmail, String message) async {
    try {
      // 获取当前用户信息
      final currentUserEmail = _supabaseClient.auth.currentUser!.email!;
      final DateTime timeStamp = DateTime.now();

      // 调用RPC函数获取或创建ChatRoom的ID
      final String chatRoomID = await _supabaseClient
          .rpc('get_or_create_chat_room', params: {
        'p_user1_email': currentUserEmail,
        'p_user2_email': receiverEmail
      });

      // 创建消息
      final newMessage = Message(
          chatRoomID: chatRoomID,
          senderEmail: currentUserEmail,
          receiverEmail: receiverEmail,
          message: message,
          timeStamp: timeStamp);
      // 插入消息到 Supabase 的 chat_message 表
      await _supabaseClient.from('chat_message').insert(newMessage.toMap());
    } catch (e) {
      throw Exception('Error occurred while sending message: $e');
    }
  }
}
