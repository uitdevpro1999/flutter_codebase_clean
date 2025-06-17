import 'package:flutter_codebase_clean/core/network/graphql/graphql_service.dart';
import 'package:flutter_codebase_clean/features/profile/data/graphql_actions/profile_queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
@LazySingleton()
class ProfileGraphqlService {
  final GraphQLService _service;
  ProfileGraphqlService(this._service);

  Future<QueryResult> getProfile() async {
    final result = await _service.query(ProfileQueries.queryProfile);
    return result;
  }
}