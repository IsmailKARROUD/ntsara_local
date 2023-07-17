import 'package:graphql_flutter/graphql_flutter.dart';

class RequestsBuilder {
  static QueryOptions<Object?> createUserMutation({
    required String id,
    String? name,
    required String email,
    String? androidToken,
    String? iOSToken,
    String? urlProfilePicture,
  }) {
    final mutation = StringBuffer('mutation { createUser(user:{ id: "$id",');

    if (name != null) {
      mutation.write(' UserName: "$name",');
    }
    if (urlProfilePicture != null) {
      mutation.write(' Url_Profile_Picture: "$urlProfilePicture",');
    }
    if (iOSToken != null && iOSToken != '') {
      mutation.write(' IOSToken: "$iOSToken",');
    }
    if (androidToken != null && androidToken != '') {
      mutation.write(' AndroidToken: "$androidToken",');
    }

    mutation
      ..write(' email: "$email",')
      ..write(
          '}) { id, UserName, email, AndroidToken, IOSToken, Url_Profile_Picture, JoinDate }')
      ..write('}');
    return QueryOptions(
        fetchPolicy: FetchPolicy.noCache, document: gql(mutation.toString()));
  }

  static QueryOptions<Object?> getUserQuery({
    required String id,
  }) {
    final query = StringBuffer(
        'query { getUser(id: "$id") { id, UserName, email, AndroidToken, IOSToken, Url_Profile_Picture, JoinDate }}');
    return QueryOptions(
        fetchPolicy: FetchPolicy.noCache, document: gql(query.toString()));
  }

  static SubscriptionOptions<Object?> getPrivateChatSubscription({
    required String id,
  }) {
    final String subscription =
        'subscription {privateChats(userID:"$id"){id,userID,friendID}}';
    return SubscriptionOptions(
      document: gql(subscription),
    );
  }

  static QueryOptions<Object?> getAllPrivateQuery({
    required String id,
  }) {
    final query = gql(r'''query ($id: ID!) {
  getAllPrivateChats(id: $id) {
    friendID
    id
    userID
  }
}
''');
    return QueryOptions(
      fetchPolicy: FetchPolicy.noCache,
      document: query,
      variables: {
        'id': id,
      },
    );
  }

  static QueryOptions<Object?> sendMessageMutation({
    required String chatId,
    String? message,
    String? location,
    required String senderId,
  }) {
    final mutation = gql(
      r'''
      mutation MyMutation($message: MessageInput!) {
  createMessage(message: $message) {
    ChatID
    createdAt
    location
    message
    senderID
    id
  }
}
    ''',
    );
    return QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: mutation,
        variables: {
          "message": {
            "ChatID": int.parse(chatId),
            "senderID": senderId,
            "message": message,
            "location": location
          }
        });
  }

  static QueryOptions<Object?> getMessagesQuery({
    required String chatId,
  }) {
    final query = gql(
      r'''
     query MyQuery($chatid: ID!) {
  getMessages(chatid: $chatid) {
    ChatID
    createdAt
    id
    location
    message
    senderID
  }
}
    ''',
    );
    return QueryOptions(
      fetchPolicy: FetchPolicy.noCache,
      document: query,
      variables: {
        'chatid': chatId,
      },
    );
  }
}
