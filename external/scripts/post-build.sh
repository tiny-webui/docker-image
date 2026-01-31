#!/bin/bash

TARGET_DIR="$1"

if [ -z "$TARGET_DIR" ]; then
  echo "Usage: $0 <target-directory>"
  exit 1
fi

echo "Post-build script executed. Target directory: $TARGET_DIR"

# Remove unused s6 binaries

echo "Removing unused s6 binaries..."

allowed_s6_binaries=(
  "s6-svscan"
  "s6-supervise"
  "s6-svc"
  "s6-svstat"
  "s6-svok"
  "s6-svscanctl"
)

declare -A allowed_map
for bin in "${allowed_s6_binaries[@]}"; do
  allowed_map["$bin"]=1
done

for path in "$TARGET_DIR"/usr/bin/s6-*; do
  [ -e "$path" ] || continue
  base=$(basename "$path")
  if [[ -n ${allowed_map[$base]} ]]; then
    continue
  fi
  echo "Removing unused s6 binary: $base"
  rm -f "$path"
done

# Remove pcre binaries

echo "Removing pcre binaries..."

rm -f "$TARGET_DIR"/usr/bin/pcre2test
rm -f "$TARGET_DIR"/usr/bin/pcre2grep

# Remove zstd binaries

echo "Removing zstd binaries..."

rm -f "$TARGET_DIR"/usr/bin/unzstd
rm -f "$TARGET_DIR"/usr/bin/zstd
rm -f "$TARGET_DIR"/usr/bin/zstdcat
rm -f "$TARGET_DIR"/usr/bin/zstdgrep
rm -f "$TARGET_DIR"/usr/bin/zstdless
rm -f "$TARGET_DIR"/usr/bin/zstdmt
