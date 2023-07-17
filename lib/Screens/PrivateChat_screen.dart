import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:ntsara_local/Chats/Location_bubble.dart';
import 'package:ntsara_local/Chats/newMessage.dart';
import 'package:ntsara_local/CustomWidget/MessageBubble.dart';
import 'package:ntsara_local/assets/Mycolors.dart';
import 'package:ntsara_local/graphqlConfig/Graphql_Function.dart';
import 'package:ntsara_local/graphqlConfig/graphql_requests.dart';
import 'package:ntsara_local/models/Message.dart';
import 'package:ntsara_local/models/UserSQL.dart';
import 'package:linkwell/linkwell.dart';

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
              child: Subscription(
                  options: RequestsBuilder.getPrivateChatSubscription(
                      id: widget.chatID),
                  builder: (result) {
                    return FutureBuilder(
                        future: FutureGraphQL().getMessages(widget.chatID),
                        builder: (context, snapshotFuture) {
                          if (snapshotFuture.connectionState ==
                                  ConnectionState.done &&
                              snapshotFuture.hasData &&
                              snapshotFuture.data!.isNotEmpty) {
                            return ListView.builder(
                                itemCount: snapshotFuture.data!.length,
                                shrinkWrap: true,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  final thisIsMe = snapshotFuture.data![index]
                                          ["senderID"] ==
                                      id;
                                  final message = ChatMessage(
                                      senderID: snapshotFuture.data![index]
                                          ["senderID"],
                                      chatID: snapshotFuture.data![index]
                                              ["ChatID"]
                                          .toString(),
                                      createdAt:
                                          DateTime.fromMicrosecondsSinceEpoch(
                                              int.parse(snapshotFuture
                                                  .data![index]["createdAt"])),
                                      messageText: snapshotFuture.data![index]
                                          ["message"],
                                      location: ChatMessage.parseLocationString(
                                          snapshotFuture.data![index]
                                              ["location"]));
                                  return MessageBubble(
                                    thisIsMe: thisIsMe,
                                    message: message,
                                  );
                                });
                          } else if (snapshotFuture.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return const Center(child: Text("No message yet."));
                          }
                        });
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
