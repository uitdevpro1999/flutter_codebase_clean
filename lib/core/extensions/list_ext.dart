import 'dart:async';

extension NullableListExt<T> on List<T>? {
  bool get isEmptyArray {
    return this == null || this!.isEmpty;
  }
}

extension ListExtension<T> on List<T> {
  List<E> castAs<E>() {
    if (isEmpty || first is! E) return [];
    return map((e) => e as E).toList();
  }
}

extension ListStreamSubscriptionExtensions<T> on List<StreamSubscription<T>> {
  Future<void> cancel() async {
    for (final sub in this) {
      await sub.cancel();
    }
  }
}
