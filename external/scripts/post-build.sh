#!/bin/bash

TARGET_DIR="$1"

if [ -z "$TARGET_DIR" ]; then
  echo "Usage: $0 <target-directory>"
  exit 1
fi

echo "Post-build script executed. Target directory: $TARGET_DIR"

