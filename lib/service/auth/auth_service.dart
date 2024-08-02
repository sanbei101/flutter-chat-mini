import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  // 定义 Supabase 客户端
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // 登入
  Future<void> signInWithEmailPassword(String email, String password) async {
    final response = await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('登录失败');
    }
  }

  //登出
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  // 注册
  Future<void> signUpWithEmailPassword(String email, String password) async {
    final response =
        await _supabaseClient.auth.signUp(email: email, password: password);
    if (response.user == null) {
      throw Exception('注册失败');
    }
  }
}
