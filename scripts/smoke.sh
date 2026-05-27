#!/bin/bash
set -euo pipefail

TIMEOUT_SECONDS="${TIMEOUT_SECONDS:-20}"
OUTPUT_FILE="${OUTPUT_FILE:-$(mktemp)}"

if command -v timeout >/dev/null 2>&1; then
  TIMEOUT_BIN=timeout
elif command -v gtimeout >/dev/null 2>&1; then
  TIMEOUT_BIN=gtimeout
else
  echo "error: timeout or gtimeout is required for the QEMU smoke test" >&2
  exit 1
fi

cleanup() {
  if [ -z "${KEEP_SMOKE_OUTPUT:-}" ]; then
    rm -f "$OUTPUT_FILE"
  else
    echo "smoke output kept at $OUTPUT_FILE"
  fi
}
trap cleanup EXIT

set +e
(
  sleep 2
  printf 'about\n'
  sleep 1
  printf 'help\n'
  sleep 1
  printf 'ps\n'
  sleep 1
  printf 'uptime\n'
  sleep 1
  printf 'meminfo\n'
  sleep 1
  printf 'intstats\n'
  sleep 1
) | "$TIMEOUT_BIN" "$TIMEOUT_SECONDS" ./scripts/run-qemu.sh >"$OUTPUT_FILE" 2>&1
status=$?
set -e

if [ "$status" -ne 0 ] && [ "$status" -ne 124 ]; then
  echo "error: QEMU smoke test exited with status $status" >&2
  cat "$OUTPUT_FILE" >&2
  exit "$status"
fi

for expected in \
  "HeliOS v1.0" \
  "HeliOS> " \
  "educational RISC-V operating system" \
  "Available commands:" \
  "PID  STATE" \
  "Uptime:" \
  "=== Memory Usage ===" \
  "ticks=" \
  "preempt="
do
  if ! grep -F "$expected" "$OUTPUT_FILE" >/dev/null; then
    echo "error: expected smoke output not found: $expected" >&2
    cat "$OUTPUT_FILE" >&2
    exit 1
  fi
done

echo "QEMU smoke test passed."
