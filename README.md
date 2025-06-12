<br>

# Astronacci APP 📱

This is a Flutter project for **Astronacci** app.

# Backend API

- [Backend API](https://github.com/ericwidhiantara/astronacci-api.git)

## Pre-requisites 📐

| Technology | Recommended Version | Installation Guide                                                    |
|------------|---------------------|-----------------------------------------------------------------------|
| Flutter    | v3.10.x             | [Flutter Official Docs](https://flutter.dev/docs/get-started/install) |
| Dart       | v3.0.x              | Installed automatically with Flutter                                  |

## Get Started 🚀

- Clone this project using `git clone https://github.com/ericwidhiantara/astronacci_app.git`
- Run `flutter pub get`
- Run `flutter gen-l10n` to generate localization files
- Run `dart run build_runner build --delete-conflicting-outputs` to generate required files
  (freezed, mocks, .g, etc)
- Make sure your server is up and running
- Make sure you already set the Env variable in `.env.prd.json` and `.env.dev.json`, set the Base
  URL to match your
  server
- You are ready to go

## Optionals 🚀

- To generate native splash screen based on
  Flavor
  `flutter clean && flutter pub get && dart run flutter_native_splash:create --flavors dev,prd`
- To generate launcher icon based on
  Flavor `dart run flutter_launcher_icons:main -f flutter_launcher_icons*`

## Run The App 🏃

For **development**

- Use `flutter run --flavor dev -t lib/main.dart --dart-define-from-file .env.dev.json` command in
  console or in Android Studio run configuration
-

For **production**

- Use `flutter run --flavor prd -t lib/main.dart --dart-define-from-file .env.prd.json --release`
  command in console or in Android Studio Run Configuration

## Run The Test 🏃

- Use `flutter test` command to run the tests

## Build The APK 🏃

For **development**

- Use `flutter build apk --flavor dev -t lib/main.dart --dart-define-from-file .env.dev.json`
  command in console or terminal

For **production**

-

Use
`flutter build apk --flavor prd -t lib/main.dart --dart-define-from-file .env.prd.json --release`
command in console or terminal

## Build The AppBundle For PlayStore Release 🏃

For **development**

- Use `flutter build appbundle --flavor dev -t lib/main.dart --dart-define-from-file .env.dev.json`
  command in console or terminal

For **production**

-

Use
`flutter build appbundle --flavor prd -t lib/main.dart --dart-define-from-file .env.prd.json --release`
command in console or terminal

## Build The IPA For App Store Release 🏃

For **development**

- Use `flutter build ipa --flavor dev -t lib/main.dart --dart-define-from-file .env.dev.json`
  command in console or terminal

For **production**

-

Use
`flutter build ipa --flavor prd -t lib/main.dart --dart-define-from-file .env.prd.json --release`
command in console or terminal

<br>

