import 'package:map_launcher/map_launcher.dart';

class ChatMessage {
  final String senderID;
  final String chatID;
  final DateTime createdAt;
  final String? messageText;
  final Coords? location;

  ChatMessage({
    required this.senderID,
    required this.chatID,
    required this.createdAt,
    this.messageText,
    this.location,
  });

  static Coords? parseLocationString(String? locationString) {
    if (locationString == null) {
      return null;
    }
    final List<String> coordinates = locationString.split('|');
    final double latitude = double.parse(coordinates[0]);
    final double longitude = double.parse(coordinates[1]);
    return Coords(latitude, longitude);
  }
}
