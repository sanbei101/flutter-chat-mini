import 'package:flutter/material.dart';
import 'package:flutterchat/components/user_tile.dart';
import 'package:flutterchat/pages/chat_page.dart';
import 'package:flutterchat/service/auth/auth_service.dart';
import 'package:flutterchat/service/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ChatService _chatService = ChatService();

  void logout() {
    final AuthService authService = AuthService();
    authService.signOut();
  }

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
            onPressed: logout,
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
        // error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        // loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        // return list view
        if (snapshot.hasData) {
          var userList = snapshot.data as List<Map<String, dynamic>>;
          return ListView(
            children: userList
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        } else {
          return const Text("No data available");
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
