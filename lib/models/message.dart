class Message {
  // 发送者和接收者的电子邮件
  final String senderEmail;
  final String receiverEmail;
  //chatRoomID
  final String chatRoomID;
  // 消息内容
  final String message;
  // 消息的时间戳
  final DateTime timeStamp;

  // 构造函数，初始化所有字段
  Message({
    required this.receiverEmail,
    required this.senderEmail,
    required this.chatRoomID,
    required this.message,
    required this.timeStamp,
  });

  // 将消息对象转换为Map，以便于存储或传输
  Map<String, dynamic> toMap() {
    return {
      'senderEmail': senderEmail,
      'receiverEmail': receiverEmail,
      'chatRoomID': chatRoomID,
      'message': message,
      'timeStamp': timeStamp.toIso8601String(),
    };
  }
}
