enum Flavor { prod, dev, uat}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {

      case Flavor.prod:
        return 'Codebase';
      case Flavor.dev:
        return 'Codebase Dev';
      case Flavor.uat:
        return 'Codebase Uat';
      default:
        return 'title';
    }
  }

  static String get apiUrl {
    switch (appFlavor) {
      case Flavor.prod:
        return '';
      case Flavor.dev:
        return '';
      case Flavor.uat:
        return '';
      default:
        return '';
    }
  }
}
