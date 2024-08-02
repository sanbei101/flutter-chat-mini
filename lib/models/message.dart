class Message {
  // 发送者的用户ID
  final String senderId;

  // 发送者的电子邮件
  final String senderEmail;

  // 接收者的用户ID
  final String receiverId;

  // 消息内容
  final String message;

  // 消息的时间戳
  final DateTime timeStamp;

  // 构造函数，初始化所有字段
  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timeStamp,
  });

  // 将消息对象转换为Map，以便于存储或传输
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timeStamp': timeStamp.toIso8601String(),
    };
  }
}
