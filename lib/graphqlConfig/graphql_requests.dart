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
    final mutation = gql(r'''
mutation (
  $AndroidToken: String,
  $IOSToken: String,
  $Url_Profile_Picture: String,
  $UserName: String,
  $email: String !,
  $id: ID!) {
  createUser(
    user: {id: $id, email: $email, AndroidToken: $AndroidToken, IOSToken: $IOSToken, Url_Profile_Picture: $Url_Profile_Picture, UserName: $UserName}
  ) {
    IOSToken
    AndroidToken
    JoinDate
    Url_Profile_Picture
    UserName
    email
    id
  }
}
''');
    return QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: mutation,
        variables: {
          "id": id,
          "UserName": name,
          "email": email,
          "AndroidToken": androidToken,
          "IOSToken": iOSToken,
          "Url_Profile_Picture": urlProfilePicture
        });
  }

  static QueryOptions<Object?> getUserQuery({
    required String id,
  }) {
    final query = gql(r'''
query ($id: ID!) {
  getUser(id: $id) {
    AndroidToken
    IOSToken
    JoinDate
    Url_Profile_Picture
    UserName
    email
    id
  }
}''');
    return QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: query,
        variables: {"id": id});
  }

  static SubscriptionOptions<Object?> getPrivateChatsSubscription({
    required String id,
  }) {
    final subscription = gql(r'''
subscription ($chatID: Int!) {
  privateChats(userID: "") {
    friendID
    id
    userID
  }
}
''');
    return SubscriptionOptions(
        document: subscription, variables: {"userID": id});
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

  static SubscriptionOptions<Object?> getPrivateChatSubscription({
    required String id,
  }) {
    final subscription = gql(
      r'''
         subscription ($chatID: Int!) {
  privatechat(chatID: $chatID) {
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
    return SubscriptionOptions(
        document: subscription, variables: {'chatID': int.parse(id)});
  }
}
