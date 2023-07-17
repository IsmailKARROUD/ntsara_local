import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:ntsara_local/Chats/Location_bubble.dart';
import 'package:ntsara_local/Chats/newMessage.dart';
import 'package:ntsara_local/assets/Mycolors.dart';
import 'package:ntsara_local/graphqlConfig/Graphql_Function.dart';
import 'package:ntsara_local/models/Message.dart';
import 'package:ntsara_local/models/UserSQL.dart';
import 'package:linkwell/linkwell.dart';
import 'package:intl/intl.dart' as intl;

class PrivateChatScreen extends StatefulWidget {
  final String chatID;
  final UserSQL user;

  PrivateChatScreen({required this.chatID, required this.user});

  @override
  _PrivateChatScreenState createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  @override
  Widget build(BuildContext context) {
    final id = "TJHS470POcTM8ree10SkhI7hQst1";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.userName),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: FutureGraphQL().getMessages(widget.chatID),
                  builder: (context, snapshotFuture) {
                    if (snapshotFuture.connectionState ==
                        ConnectionState.done) {
                      return ListView.builder(
                          itemCount: snapshotFuture.data!.length,
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context, index) {
                            final thisIsMe =
                                snapshotFuture.data![index]["senderID"] == id;
                            final message = ChatMessage(
                                senderID: snapshotFuture.data![index]
                                    ["senderID"],
                                chatID: snapshotFuture.data![index]["ChatID"]
                                    .toString(),
                                createdAt: DateTime.fromMicrosecondsSinceEpoch(
                                    int.parse(snapshotFuture.data![index]
                                        ["createdAt"])),
                                messageText: snapshotFuture.data![index]
                                    ["message"],
                                location: ChatMessage.parseLocationString(
                                    snapshotFuture.data![index]["location"]));
                            return Row(
                              mainAxisAlignment: thisIsMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: thisIsMe
                                            ? myKingGreen
                                            : Colors.grey[300],
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment: thisIsMe
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 7,
                                              bottom: 0,
                                              left: 16,
                                              right: 16),
                                          child: message.messageText == null
                                              ? LocationBubble(
                                                  location: message.location!,
                                                  createdAt: message.createdAt,
                                                  thisMe: thisIsMe)
                                              : LinkWell(
                                                  message.messageText ??
                                                      "No message sent",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: thisIsMe
                                                          ? myWhite
                                                          : myBlack),
                                                ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 0,
                                              bottom: 3,
                                              left: 7,
                                              right: 7),
                                          child: Text(
                                            intl.DateFormat("HH:mm").format(
                                                DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        int.parse(snapshotFuture
                                                                .data![index]
                                                            ["createdAt"]))),
                                            style: TextStyle(
                                                fontSize: 10.5,
                                                fontWeight: FontWeight.bold,
                                                color: thisIsMe
                                                    ? myBlack[700]
                                                    : myKingGreen[800]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    }
                    {
                      return Center(
                        child: Text("data"),
                      );
                    }
                  })),
          NewMessage(
            senderID: id,
            chatID: widget.chatID,
            isitPrivate: true,
          )
        ],
      ),
    );
  }
}
