import 'package:flutter/material.dart';
import 'package:flutterchat/components/chat_bubble.dart';
import 'package:flutterchat/components/my_textfiled.dart';
import 'package:flutterchat/service/chat/chat_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.receiverEmail});

  final String receiverEmail;
  final String senderEmail = Supabase.instance.client.auth.currentUser!.email!;
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();

  void sendMessage() {
    // 获取消息内容
    final message = messageController.text;

    // 发送消息
    chatService.sendMessage(receiverEmail, message);
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildMessageList(),
          //input field
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: chatService.getMessagesStream(senderEmail, receiverEmail),
      builder: (context, snapshot) {
        // 处理错误情况
        if (snapshot.hasError) {
          return const Text("加载错误");
        }
        // 处理加载情况
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("加载中...");
        }
        // 返回消息列表视图
        if (snapshot.hasData) {
          return ListView(
            children:
                snapshot.data!.map((user) => _buildMessageItem(user)).toList(),
          );
        } else {
          return const Text("没有数据");
        }
      },
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> data) {
    //判断是否为当前用户
    final isCurrentUser = data["senderEmail"] == senderEmail;
    // 如果发送者是当前用户，将消息对齐到右边，否则对齐到左边
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isSender: isCurrentUser),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          Expanded(
            child: MyTextfiled(
              controller: messageController,
              hintText: '输入消息',
              obscureText: false,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
