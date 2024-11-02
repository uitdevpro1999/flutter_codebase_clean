import 'package:flutter_codebase_clean/core/common/bases/entities/sort_entity.dart';

class PageableEntity {
  SortEntity? sort;
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? paged;
  bool? unpaged;

  PageableEntity({
    this.sort,
    this.offset,
    this.pageNumber,
    this.pageSize,
    this.paged,
    this.unpaged,
  });
}
