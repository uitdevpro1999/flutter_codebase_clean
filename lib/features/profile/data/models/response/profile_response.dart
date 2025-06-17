import 'package:flutter_codebase_clean/core/mapper/entity_convertible.dart';
import 'package:flutter_codebase_clean/features/auth/domain/entities/auth_entity.dart';
import 'package:flutter_codebase_clean/features/profile/domain/entities/profile_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse with EntityConvertible<ProfileResponse, ProfileEntity> {
  String? name;
  String? phone;
  ProfileResponse({this.name, this.phone});
  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileResponseFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);

  @override
  ProfileEntity toEntity() {
    return ProfileEntity(
      phone: phone,
      name: name,
    );
  }
}
