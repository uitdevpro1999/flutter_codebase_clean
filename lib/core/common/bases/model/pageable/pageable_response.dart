import 'package:flutter_codebase_clean/core/common/bases/entities/pageable_entity.dart';
import 'package:flutter_codebase_clean/core/common/bases/model/pageable/sort_response.dart';
import 'package:flutter_codebase_clean/core/mapper/entity_convertible.dart';
import 'package:json_annotation/json_annotation.dart';
part 'pageable_response.g.dart';

@JsonSerializable(createToJson: false)
class PageableResponse
    with EntityConvertible<PageableResponse, PageableEntity> {
  @JsonKey(name: 'sort')
  SortResponse? sort;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'pageNumber')
  int? pageNumber;
  @JsonKey(name: 'offset')
  int? offset;
  @JsonKey(name: 'unpaged')
  bool? unpaged;
  @JsonKey(name: 'paged')
  bool? paged;

  PageableResponse({
    this.sort,
    this.pageSize,
    this.pageNumber,
    this.offset,
    this.unpaged,
    this.paged,
  });

  factory PageableResponse.fromJson(Map<String, dynamic> json) {
    return _$PageableResponseFromJson(json);
  }

  @override
  PageableEntity toEntity() {
    return PageableEntity(
      sort: sort?.toEntity(),
      paged: paged,
      pageNumber: pageNumber,
      pageSize: pageSize,
      offset: offset,
      unpaged: unpaged,
    );
  }
}
