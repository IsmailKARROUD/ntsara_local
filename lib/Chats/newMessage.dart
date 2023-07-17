// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ntsara_local/Providers/locationProvider.dart';
// import 'package:flutterchat/API/FCM_notification_service.dart';
// import 'package:flutterchat/Providers/locationProvider.dart';
// import 'package:flutterchat/assets/Mycolors.dart';
// import 'package:flutterchat/models/FirestoreUser.dart';
// import 'package:flutterchat/models/GroupVariable.dart';
import 'package:ntsara_local/assets/Mycolors.dart';
import 'package:ntsara_local/graphqlConfig/graphql.dart';
import 'package:ntsara_local/graphqlConfig/graphql_requests.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  final String senderID;
  final String chatID;
  final bool isitPrivate;
  // final FirestoreUser? friend;
  // final GroupVariable? group;

  const NewMessage({
    required this.senderID,
    required this.chatID,
    required this.isitPrivate,
    // this.friend,
    // this.group,
    Key? key,
  }) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  GraphQLClient client = GraphQLConfiguration.clientToQuery();
  var _newmessage = '';
  var _newmessagelocaly = '';
  final _controllerNewMessage = new TextEditingController();
  bool _loadingLocation = false;

  void _sendMessage() async {
    try {
      setState(() {
        _newmessage = _newmessagelocaly;
        _newmessagelocaly = '';
      });
      if (widget.isitPrivate) {
        _controllerNewMessage.clear();
        // await FirebaseFirestore.instance
        //     .collection('PrivateChat')
        //     .doc(widget.chatID)
        //     .collection("messages")
        //     .add({
        //   'Message': _newmessage.trim(),
        //   'CreateAt': FieldValue.serverTimestamp(),
        //   'SenderID': widget.senderID,
        //   'Read': false,
        // }).then((_) {
        //   FCMNotificationService().sendNotificationToUser(
        //     friend: widget.friend!,
        //     message: _newmessage,
        //     title: "New private message!",
        //     notificationType: "New private message",
        //     chatID: widget.chatID,
        //   );
        // });
        final v = await client.query(RequestsBuilder.sendMessageMutation(
            chatId: widget.chatID,
            senderId: widget.senderID,
            message: _newmessage));
        print(v);
      } else {
        _controllerNewMessage.clear();
        // await FirebaseFirestore.instance
        //     .collection('GroupChat')
        //     .doc(widget.chatID)
        //     .collection("messages")
        //     .add({
        //   'Message': _newmessage,
        //   'CreateAt': FieldValue.serverTimestamp(),
        //   'SenderID': widget.senderID,
        //   'Read': [FirebaseAuth.instance.currentUser!.uid],
        // }).then((_) {
        //   FCMNotificationService().sendNotificationToGroup(
        //       group: "Group_" + widget.chatID,
        //       chatID: widget.chatID,
        //       message: _newmessage,
        //       notificationType: "New message Group",
        //       title: widget.group == null
        //           ? "New message Group"
        //           : widget.group!.name);
        // });
      }
    } catch (error) {
      print("Erreur when sending newmessage :" + error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 9.0, left: 5.0),
            child: TextField(
              controller: _controllerNewMessage,
              textCapitalization: TextCapitalization.sentences,

              scribbleEnabled: true,
              showCursor: true,
              // to enable suggestion
              autocorrect: true,
              enableSuggestions: true,

              keyboardType: TextInputType.multiline,
              //to not go in the right and return to newline
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Send a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _newmessagelocaly = value;
                });
              },
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 9.0,
            ),
            child: AnimatedCrossFade(
              duration: Duration(milliseconds: 250),
              crossFadeState:
                  _newmessagelocaly == '' || _newmessagelocaly.isEmpty
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
              firstChild: AnimatedCrossFade(
                duration: Duration(milliseconds: 250),
                crossFadeState: _loadingLocation
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircularProgressIndicator(),
                ),
                secondChild: IconButton(
                  icon: Icon(
                    Icons.location_pin,
                    color: myKingGreen,
                  ),
                  onPressed: () async {
                    setState(() {
                      _loadingLocation = true;
                    });

                    /// send location
                    await Provider.of<LocationProvider>(context, listen: false)
                        .sendLocation(
                            isitPrivate: true,
                            chatID: widget.chatID,
                            senderID: widget.senderID);
                    setState(() {
                      _loadingLocation = false;
                    });
                  },
                ),
              ),
              secondChild: IconButton(
                icon: Icon(
                  Icons.send,
                  color: myKingGreen,
                ),
                onPressed: () {
                  return _sendMessage();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
