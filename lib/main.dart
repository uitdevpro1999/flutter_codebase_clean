import 'dart:async';

import 'package:flutter_codebase_clean/flavors.dart';
import 'package:flutter_codebase_clean/start.dart';

FutureOr<void> main() async {
  F.appFlavor = Flavor.prod;
  await start();
}
