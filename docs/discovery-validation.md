# Validation — 2026-10-28

Implementation remains local. Production, retailer configuration and hosting
billing were not changed. The user chose to keep hosting free and accept
best-effort availability. The paid blueprint is an optional reference.

Passed:
- Discovery PHP feature suite: 11 tests, 46 assertions (isolated SQLite).
- Deployment/source-probe Python suite: 9 tests, including preservation of the current compute plan.
- Existing Brazilian deal engine Python suite: 21 tests.
- PHP Pint on the 11 new/changed PHP files.
- PHPStan level 5 on discovery production files, serial debug mode. Temporary
  check config disabled unmatched baseline-ignore reporting for this subset.
- Flutter analysis of app lib/ and test/: no issues.
- Flutter debug Dart asset bundle compilation. This is not an Android APK.
- Laravel discovery routes registered and polling scheduled every minute.
- git diff --check.

Blocked by sandbox restrictions:
- APK build: Gradle 9.3.1 distribution was not cached; downloading it failed with
  java.net.SocketException: Operation not permitted. No new APK was produced.
- Flutter widget tests: test runner could not bind its localhost server socket.
  Regression cases for sign-in routing, restored tokens and feed errors are
  supplied for the Android CI workflow, but have not executed locally.
- Live retailer endpoint verification and deployment: shell network unavailable;
  attempts to inspect candidate catalog URLs through web browsing also failed.
  No retailer endpoint is represented as verified or enabled by default.

The root Flutter analyze command also encounters pre-existing generated API test
stubs with unresolved legacy test dependencies. The app check deliberately targets
lib and test. See mobile/README.md for the separate generated-package limitation.

Still required to activate: verify and configure one actual retailer/producer,
apply migrations and backend code, then build/download and device-test the APK
in a network-enabled runner. FCM pushes, 90-day/record-low rules, full catalog
pagination and a guaranteed continuous service are outside this implemented slice.

Local follow-up improvements:
- Batched history reads: the regression suite confirms 20 deal cards use one
  history query, and current watch rules supply the displayed reason.
- Malformed feed envelopes fail source health instead of masquerading as empty
  successful catalogs. An explicit empty offers array remains valid.
- Mobile watches support pause/resume, deletion confirmation and refresh.
- Watch/alert providers handle load and mutation failures, expose retry messages,
  clear previous list data on refresh and prevent concurrent duplicate actions.
- Three provider regression cases were added and pass static analysis; runtime
  execution remains pending because the Flutter test runner needs a local socket.
- User requested local work only from this point; provide the manual deployment
  commands when the user explicitly says the session is finished.
