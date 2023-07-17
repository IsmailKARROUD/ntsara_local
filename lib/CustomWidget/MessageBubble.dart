import 'package:flutter/material.dart';
import 'package:linkwell/linkwell.dart';
import 'package:ntsara_local/Chats/Location_bubble.dart';
import 'package:ntsara_local/assets/Mycolors.dart';
import 'package:ntsara_local/models/Message.dart';
import 'package:intl/intl.dart' as intl;

class MessageBubble extends StatelessWidget {
  final bool thisIsMe;
  final ChatMessage message;

  const MessageBubble(
      {super.key, required this.message, required this.thisIsMe});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          thisIsMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: thisIsMe ? myKingGreen : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: thisIsMe
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: thisIsMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                )),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              crossAxisAlignment:
                  thisIsMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 7, bottom: 0, left: 16, right: 16),
                  child: message.messageText == null
                      ? LocationBubble(
                          location: message.location!,
                          createdAt: message.createdAt,
                          thisMe: thisIsMe)
                      : LinkWell(
                          message.messageText ?? "No message sent",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: thisIsMe ? myWhite : myBlack),
                        ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 3, left: 7, right: 7),
                  child: Text(
                    intl.DateFormat("HH:mm").format(message.createdAt),
                    style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: thisIsMe ? myBlack[700] : myKingGreen[800]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
