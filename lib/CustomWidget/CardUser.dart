import 'package:flutter/material.dart';
import 'package:ntsara_local/graphqlConfig/Graphql_Function.dart';
import 'package:ntsara_local/models/PrivateChat.dart';
import 'package:ntsara_local/models/UserSQL.dart';
import 'package:ntsara_local/CustomWidget/makingSure_pop-Up.dart';
import 'package:ntsara_local/Screens/PrivateChat_screen.dart';

class CardUser extends StatelessWidget {
  final PrivateChat privatechat;
  final id = "TJHS470POcTM8ree10SkhI7hQst1";

  const CardUser({
    Key? key,
    required this.privatechat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserSQL>(
        future: FutureGraphQL().getUser(
            //because we don't know who create the friendship
            privatechat.iD == id ? privatechat.friendID : privatechat.userID),
        builder: (context, snapshotUser) {
          if (snapshotUser.connectionState == ConnectionState.done) {
            return Card(
              child: ListTile(
                leading: const CircleAvatar(
                    radius: 22,
                    foregroundImage:
                        AssetImage('lib/assets/images/UnkownPP.jpeg')),
                title: Text(snapshotUser.data!.userName),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    makingSurePopUp(
                        context: context,
                        title: "Delete a friend?",
                        message:
                            "Do you want to remove ${snapshotUser.data!.userName} as a friend?",
                        firstOnPressed: () {
                          // Provider.of<PrivateChatProvider>(context,
                          //         listen: false)
                          //     .deleteFriend(
                          //         _pcv.iD, _theFriend, context);
                          Navigator.of(context).pop();
                        },
                        secondOnPressed: () {
                          Navigator.of(context).pop();
                        });
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return PrivateChatScreen(
                        chatID: privatechat.iD,
                        user: snapshotUser.data!,
                      );
                    }),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
