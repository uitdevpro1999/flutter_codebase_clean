import 'package:json_annotation/json_annotation.dart';
part 'login_request.g.dart';

@JsonSerializable(createFactory: false)
class LoginRequest {
  String? username;
  String? password;
  LoginRequest({this.username, this.password});
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
