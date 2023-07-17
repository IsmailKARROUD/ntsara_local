import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:ntsara_local/CustomWidget/CardUser.dart';

import 'package:ntsara_local/graphqlConfig/Graphql_Function.dart';
import 'package:ntsara_local/models/PrivateChat.dart';

import '../graphqlConfig/graphql_requests.dart';

class ManagePrivateChatScreen extends StatefulWidget {
  const ManagePrivateChatScreen({super.key});

  @override
  State<ManagePrivateChatScreen> createState() =>
      _ManagePrivateChatScreenState();
}

class _ManagePrivateChatScreenState extends State<ManagePrivateChatScreen> {
  @override
  Widget build(BuildContext context) {
    final id = "TJHS470POcTM8ree10SkhI7hQst1";

    return Subscription(
      options: RequestsBuilder.getPrivatesChatSubscription(id: id),
      builder: (result) {
        return FutureBuilder<List<dynamic>>(
            future: FutureGraphQL().getAllPrivateChats(id),
            builder: (context, snapshotFuture) {
              if (snapshotFuture.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshotFuture.hasError) {
                return Text('Error: ${snapshotFuture.error}');
              } else if (!snapshotFuture.hasData) {
                return Text('No data available');
              } else {
                return ListView.builder(
                    itemCount: snapshotFuture.data!.length,
                    itemBuilder: (context, index) {
                      return CardUser(
                          privatechat: PrivateChat(
                              iD: snapshotFuture.data![index]["id"].toString(),
                              friendID: snapshotFuture.data![index]["friendID"],
                              userID: snapshotFuture.data![index]["userID"]));
                    });
              }
            });
      },
    );
  }
}
