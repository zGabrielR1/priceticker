# PriceTicker Android

Flutter 3.47.7 / Dart 3.13.5, JDK 17, Android SDK. Version 1.1.0+2.

```sh
flutter pub get
flutter analyze lib test
flutter test
flutter build apk --debug --dart-define=API_BASE_URL=https://priceticker.onrender.com
```

APK: `build/app/outputs/flutter-apk/app-debug.apk`. This is a debug-signed preview,
not a production signing identity. For an emulator backend, set API_BASE_URL to
its reachable address explicitly; production defaults to HTTPS on Render.

The Android preview GitHub workflow uploads the APK after checks pass. The local
sandbox on 2026-10-28 could resolve cached Dart packages but blocked Gradle's
network download and Flutter tests' localhost socket; no new APK was produced
there. Run the workflow or these commands in an environment with those permissions.

Deploy the new backend migrations/endpoints before using the deal feed. Configure
retailer sources as described in [discovery.md](../docs/discovery.md). Creating a
watch requires keywords; an optional BRL target matches immediately, otherwise
historical discounts need at least seven prior observed days. Source health and
empty/error states indicate missing configuration or connectivity.

Firebase remains optional and requires your own google-services.json. Discovery
in this version populates the deal feed and database alert inbox; FCM deal pushes
are not wired up. Existing
product charts and alert routes remain available.

The generated API package under packages/priceticker_api has legacy test stubs
and its own test SDK constraint. Analyze the app via `flutter analyze lib test`;
regenerate/update that package's test tooling before treating its generated
stubs as an independent executable suite.
