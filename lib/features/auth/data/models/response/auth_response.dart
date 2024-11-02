import 'package:flutter_codebase_clean/core/mapper/entity_convertible.dart';
import 'package:flutter_codebase_clean/features/auth/domain/entities/auth_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse with EntityConvertible<AuthResponse, Auth> {
  @JsonKey(name: 'access_token')
  String? accessToken;
  @JsonKey(name: 'expires_in')
  int? expiresIn;
  @JsonKey(name: 'refresh_expires_in')
  int? refreshExpiresIn;
  @JsonKey(name: 'refresh_token')
  String? refreshToken;
  @JsonKey(name: 'token_type')
  String? tokenType;
  @JsonKey(name: 'id_token')
  String? idToken;
  @JsonKey(name: 'not-before-policy')
  int? notBeforePolicy;
  @JsonKey(name: 'session_state')
  String? sessionState;
  String? scope;
  String? error;
  @JsonKey(name: 'error_description')
  String? errorDescription;
  @JsonKey(name: 'error_uri')
  String? errorUri;
  AuthResponse(
      {this.accessToken,
      this.error,
      this.errorDescription,
      this.errorUri,
      this.expiresIn,
      this.idToken,
      this.notBeforePolicy,
      this.refreshExpiresIn,
      this.refreshToken,
      this.scope,
      this.sessionState,
      this.tokenType});
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return _$AuthResponseFromJson(json);
  }
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  @override
  Auth toEntity() {
    return Auth(
      accessToken: accessToken,
      error: error,
      errorDescription: errorDescription,
      errorUri: errorUri,
      expiresIn: expiresIn,
      idToken: idToken,
      notBeforePolicy: notBeforePolicy,
      refreshExpiresIn: refreshExpiresIn,
      refreshToken: refreshToken,
      scope: scope,
      sessionState: sessionState,
      tokenType: tokenType,
    );
  }
}
