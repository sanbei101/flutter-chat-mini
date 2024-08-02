import 'package:flutter/material.dart';
import 'package:flutterchat/components/my_textfiled.dart';
import 'package:flutterchat/service/auth/auth_service.dart';
import 'package:flutterchat/service/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  final String receiverEmail;
  final String receiverId;
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  void sendMessage() {
    // 获取消息内容
    final message = messageController.text;

    // 发送消息
    chatService.sendMessage(receiverId, message);
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
          //input field
          _buildInputField(),
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
              hintText: 'Type a message...',
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
