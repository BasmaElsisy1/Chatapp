class Message {
  String id;
  String content;
  int dateTime;
  String senderName;
  String senderId;
  String roomId;

  Message(
      {this.id = '',
      required this.content,
      required this.dateTime,
      required this.roomId,
      required this.senderId,
      required this.senderName});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "dateTime": dateTime,
      "senderName": senderName,
      "senderId": senderId,
      "roomId": roomId,
    };
  }

  Message.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            content: json['content'],
            dateTime: json['dateTime'],
            senderName: json['senderName'],
            senderId: json['senderId'],
            roomId: json['roomId']);
}
