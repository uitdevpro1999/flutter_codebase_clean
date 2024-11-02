

import 'package:flutter_codebase_clean/core/common/bases/entities/pageable_entity.dart';
import 'package:flutter_codebase_clean/core/common/bases/entities/sort_entity.dart';

class BasePagingEntity<E> {
  final PageableEntity? pageable;
  final int? totalPages;
  final int totalElements;
  final bool last;
  final int? size;
  final int? number;
  final SortEntity? sort;
  final bool? first;
  final int? numberOfElements;
  final bool? empty;
  final List<E> content;

  BasePagingEntity({
    this.pageable,
    this.totalPages,
    required this.totalElements,
    required this.last,
    this.size,
    this.number,
    this.sort,
    this.first,
    this.numberOfElements,
    this.empty,
    this.content = const [],
  });
}
