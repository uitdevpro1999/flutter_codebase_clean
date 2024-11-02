import 'package:flutter/material.dart';

class RoutingTransitions {
  static Route<dynamic> animRoute(Widget page, {RouteSettings? settings}) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => page,
    );
  }
}
