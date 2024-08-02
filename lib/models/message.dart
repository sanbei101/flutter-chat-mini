class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final DateTime timeStamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timeStamp,
  });

  //将数据转换为Map
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
