#!/usr/bin/env bash
# Generate a Dart API client from the exported OpenAPI spec.
# Prerequisite: export the spec from Laravel first:
#   php artisan scramble:export   # writes api.json
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SPEC="$ROOT/api.json"
OUT="$ROOT/mobile/lib/generated/api_client"
GEN="/tmp/opencode/openapi-generator-cli.jar"
if [ ! -f "$SPEC" ]; then
  echo "Missing $SPEC. Run: php artisan scramble:export" >&2; exit 1; fi
if [ ! -f "$GEN" ]; then
  echo "Missing generator jar. Download from https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/" >&2; exit 1; fi
rm -rf "$OUT"
java -jar "$GEN" generate -i "$SPEC" -g dart-dio -o "$OUT" --additional-properties=pubName=priceticker_api
echo "Generated client at $OUT (requires build_runner for serializers)."
