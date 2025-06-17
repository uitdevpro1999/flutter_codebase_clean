import 'package:flutter_codebase_clean/features/profile/data/datasources/profile_graphql_services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileRemoteDataSources {
  Future<QueryResult> getProfile();
}

@Injectable(as: ProfileRemoteDataSources)
class ProfileRemoteDataSourcesImpl extends ProfileRemoteDataSources {
  final ProfileGraphqlService _graphqlService;
 ProfileRemoteDataSourcesImpl(this._graphqlService);

  @override
  Future<QueryResult> getProfile() async {
    return await _graphqlService.getProfile();
  }
}
