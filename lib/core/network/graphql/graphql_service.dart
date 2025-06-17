import 'package:flutter_codebase_clean/core/local_storage/share_preferences.dart';
import 'package:flutter_codebase_clean/flavors.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GraphQLService {
  late final GraphQLClient _client;
  final AppPreferences appPreferences;

  GraphQLService(this.appPreferences) {
    final httpLink = HttpLink(F.graphQLUrl); // Lấy URL theo Flavor

    final authLink = AuthLink(
      getToken: () async {
        final token = appPreferences.authToken;
        return token != null ? 'Bearer $token' : null;
      },
    );

    final link = authLink.concat(httpLink);

    _client = GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    );
  }

  GraphQLClient get client => _client;

  Future<QueryResult> query(String document, {Map<String, dynamic>? variables}) {
    return _client.query(
      QueryOptions(document: gql(document), variables: variables ?? {}),
    );
  }

  Future<QueryResult> mutate(String document, {Map<String, dynamic>? variables}) {
    return _client.mutate(
      MutationOptions(document: gql(document), variables: variables ?? {}),
    );
  }
}