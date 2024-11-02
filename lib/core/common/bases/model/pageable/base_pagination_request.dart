import 'package:flutter_codebase_clean/core/constants/constants.dart';

class BasePaginationRequest {
  final int page;
  final int pageSize;

  BasePaginationRequest(this.page, {this.pageSize = Consts.defaultPageSize});
}
