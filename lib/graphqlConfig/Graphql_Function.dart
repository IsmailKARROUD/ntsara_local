import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ntsara_local/models/UserSQL.dart';
import './graphql.dart';
import './graphql_requests.dart';

class FutureGraphQL {
  final GraphQLClient _client = GraphQLConfiguration.clientToQuery();

  Future<List<dynamic>> getAllPrivateChats(String userId) async {
    final options = RequestsBuilder.getAllPrivateQuery(id: userId);
    final result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    }

    final data = result.data!['getAllPrivateChats'] as List<dynamic>;
    return data;
  }

  Future<UserSQL> getUser(String id) async {
    final options = RequestsBuilder.getUserQuery(id: id);
    final result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    }
    final user = result.data!['getUser'] as Map<String, dynamic>;

    final userql = UserSQL(
      id: user['id'] ?? '',
      userName: user['UserName'] ?? '',
      email: user['email'] ?? '',
      androidToken: user['AndroidToken'] ?? '',
      iosToken: user['IOSToken'] ?? '',
      urlProfilePicture: user['Url_Profile_Picture'] ?? '',
      joinDate:
          DateTime.fromMillisecondsSinceEpoch(int.parse(user['JoinDate']) ?? 0),
    );

    return userql;
  }

  Future<List<dynamic>> getMessages(String chatId) async {
    final options = RequestsBuilder.getMessagesQuery(chatId: chatId);
    final result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    }

    final data = result.data!['getMessages'] as List<dynamic>;
    return data;
  }
}
