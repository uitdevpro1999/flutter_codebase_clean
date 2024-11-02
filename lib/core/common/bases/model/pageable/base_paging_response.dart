import 'package:flutter_codebase_clean/core/common/bases/entities/base_paging_entity.dart';
import 'package:flutter_codebase_clean/core/common/bases/model/pageable/pageable_response.dart';
import 'package:flutter_codebase_clean/core/common/bases/model/pageable/sort_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';


part 'base_paging_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class BasePagingResponse<T> {
  @JsonKey(name: 'totalPages')
  int? totalPages;
  @JsonKey(name: 'totalElements')
  int? totalElements;
  @JsonKey(name: 'size')
  int? size;
  @JsonKey(name: 'content')
  List<T> content;
  @JsonKey(name: 'number')
  int? number;
  @JsonKey(name: 'sort')
  SortResponse? sort;
  @JsonKey(name: 'pageable')
  PageableResponse? pageable;
  @JsonKey(name: 'numberOfElements')
  int? numberOfElements;
  @JsonKey(name: 'first')
  bool? first;
  @JsonKey(name: 'last')
  bool? last;
  @JsonKey(name: 'empty')
  bool? empty;

  BasePagingResponse(
      {this.totalPages,
      this.totalElements,
      this.size,
      this.content = const [],
      this.number,
      this.sort,
      this.pageable,
      this.numberOfElements,
      this.first,
      this.last,
      this.empty});

  factory BasePagingResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BasePagingResponseFromJson(json, fromJsonT);

  BasePagingEntity<E> toEntity<E>(E Function(T) toElementEntity) {
    return BasePagingEntity<E>(
      totalPages: totalPages,
      totalElements: totalElements ?? 0,
      size: size,
      content: content.map(toElementEntity).toList(),
      number: number,
      sort: sort?.toEntity(),
      pageable: pageable?.toEntity(),
      numberOfElements: numberOfElements,
      first: first,
      last: last ?? true,
      empty: empty,
    );
  }
}
