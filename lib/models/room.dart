class Rooms {
  static const String Collection_Name = 'Rooms';
  String id;
  String roomName;
  String roomDescription;
  String catId;

  Rooms(
      {this.id = '',
      required this.roomName,
      required this.roomDescription,
      required this.catId});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "roomName": roomName,
      "roomDescription": roomDescription,
      "catId": catId,
    };
  }

  Rooms.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          roomName: json['roomName'],
          roomDescription: json['roomDescription'],
          catId: json['catId'],
        );
}
