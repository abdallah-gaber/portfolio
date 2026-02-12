#!/usr/bin/env bash
set -euo pipefail

# 1) Download Flutter SDK (stable)
FLUTTER_VERSION="3.41.0"
curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" -o flutter.tar.xz
tar -xf flutter.tar.xz
export PATH="$PWD/flutter/bin:$PATH"

# 2) Build Flutter Web
flutter --version
flutter config --enable-web
flutter pub get

# IMPORTANT: release build + correct base href
flutter build web --release --base-href "/"
