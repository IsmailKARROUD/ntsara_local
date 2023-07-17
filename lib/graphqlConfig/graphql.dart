import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  static late ValueNotifier<GraphQLClient> client;

  static Future<void> initGraphQL() async {
    final HttpLink httpLink = HttpLink(
      'http://192.168.1.11:4000/graphql',
    );

    const String websocketEndpoint = 'ws://192.168.1.11:4000/graphql';

    Link link = httpLink;

    final wsLink = WebSocketLink(
      websocketEndpoint,
      subProtocol: GraphQLProtocol.graphqlTransportWs,
    );

    link = Link.split((request) => request.isSubscription, wsLink, link);

    client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
  }

  static GraphQLClient clientToQuery() {
    return GraphQLClient(
      link: client.value.link,
      cache: client.value.cache,
    );
  }
}
