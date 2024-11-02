import 'package:collection/collection.dart';

/// Manage all routes in the app, for detail pages make sure to add the `_` suffix to [value]
/// and pass a class extending [Detail Arguments] to the Navigator arguments to append `id` to the path
enum AppRoutes {
  /// Auth Feature
  login('login'),

  /// main
  main('main'),
  ;

  final String value;

  const AppRoutes(this.value);

  bool get isDetailPage => value.endsWith('_');

  String get pathValue =>
      isDetailPage ? value.substring(0, value.length - 1) : value;


  String path(String? id) => isDetailPage ? '/$pathValue/$id' : '/$pathValue';

  static AppRoutes? fromPath(String path, {String? id}) =>
      AppRoutes.values.firstWhereOrNull((element) => element.path(id) == path);
}
