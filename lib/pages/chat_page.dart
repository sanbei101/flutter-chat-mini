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
    final message = messageController.text;
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
          Expanded(
            child: _buildMessageList(),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: chatService.getMessagesStream(senderEmail, receiverEmail),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("加载错误: ${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return ListView.builder(
            reverse: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return _buildMessageItem(snapshot.data![index]);
            },
          );
        } else {
          return const Center(child: Text("没有数据"));
        }
      },
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> data) {
    final isCurrentUser = data["senderEmail"] == senderEmail;
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
            margin: const EdgeInsets.only(left: 8),
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
