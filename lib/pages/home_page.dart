import 'package:flutter/material.dart';
import 'package:flutterchat/components/user_tile.dart';
import 'package:flutterchat/pages/chat_page.dart';
import 'package:flutterchat/service/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.signOut});
  final ChatService _chatService = ChatService();

  final VoidCallback signOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        title: const Text("主页"),
        actions: [
          //登出按钮
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: signOut,
          ),
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // 错误处理
        if (snapshot.hasError) {
          return const Center(child: Text("加载错误"));
        }

        //正在加载
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        //返回用户列表视图
        if (snapshot.hasData) {
          var userList = snapshot.data as List<Map<String, dynamic>>;
          return ListView(
            children: userList
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        } else {
          return const Center(child: Text("加载错误"));
        }
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      text: userData["email"],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData["email"],
            ),
          ),
        );
      },
    );
  }
}
