clean-app:
	fvm use 3.22.2 && fvm flutter clean
get-library:
	fvm flutter pub get
gen-asset:
	fvm dart run build_runner build -d && fvm dart run easy_localization:generate -S ./assets/localizations -s vi.json -f keys -o locale_keys.gen.dart
gen-localization:
	fvm dart run easy_localization:generate -S ./assets/translations -s vi.json -f keys -o locale_keys.gen.dart
watch-gen-asset:
	fvm flutter pub run build_runner watch --delete-conflicting-outputs && fvm dart run easy_localization:generate -S ./assets/translations -s vi.json -f keys -o locale_keys.gen.dart
debug-dev:
	 fvm flutter run --flavor dev -t lib/main_dev.dart
debug-prod:
	fvm flutter run --flavor prod -t lib/main_prod.dart
build-apk-dev:
	fvm flutter build apk --flavor dev -t lib/main_dev.dart --release
build-aab-dev:
	fvm flutter build apk --flavor uat -t lib/main_uat.dart --release
build-ios-dev:
	fvm flutter build ios --flavor dev -t lib/main_dev.dart --release
build-apk-prod:
	fvm flutter build apk --flavor prod -t lib/main_prod.dart --release
build-aab-prod:
	fvm flutter build appbundle --flavor prod -t lib/main_prod.dart --release
build-ios-prod:
	fvm flutter build ios --flavor prod -t lib/main_prod.dart --release
build-ios-uat:
	fvm flutter build ios --flavor uat -t lib/main_uat.dart --release
build-apk-uat:
	fvm flutter build apk --flavor uat -t lib/main_uat.dart --release

all-dev: clean-app get-library gen-asset build-apk-dev build-ios-dev
all-prod: build-aab-prod build-ios-prod
build-dev: build-ios-dev build-apk-dev
build-uat: build-ios-uat build-apk-uat
build-dev-nGen: build-ios-dev build-apk-dev
gen-app: clean-app get-library gen-asset
watch_gen-app: clean-app get-library watch_gen-asset