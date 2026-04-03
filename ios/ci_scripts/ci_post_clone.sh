#!/bin/sh
# ci_post_clone.sh
# Xcode Cloud CI script — runs after the repo is cloned.
# Installs Flutter, restores secret config files from environment variables,
# and builds the Flutter iOS app.
#
# Required Xcode Cloud Environment Variables (set in App Store Connect):
#   FLUTTER_VERSION          - Flutter version to install (e.g. "3.35.4")
#   GOOGLE_SERVICE_INFO      - Base64-encoded GoogleService-Info.plist
#   ENV_FILE                 - Base64-encoded .env file
#   ENVIRONMENT_JSON         - Base64-encoded environment.json
#   GOOGLE_SERVICES_ANDROID  - Base64-encoded google-services.json (optional, for reference)

set -e

echo "=== Xcode Cloud CI: Post Clone ==="

# ─── Navigate to project root ───
cd "$CI_PRIMARY_REPOSITORY_PATH"

# ─── Install Git LFS (required for invertase/firestore-ios-sdk-frameworks) ───
if command -v git-lfs &>/dev/null; then
    echo "Git LFS already installed."
else
    echo "Installing Git LFS..."
    brew install git-lfs
fi
git lfs install

# ─── Install Flutter ───
echo "Installing Flutter ${FLUTTER_VERSION:-3.35.4}..."
FLUTTER_VERSION="${FLUTTER_VERSION:-3.35.4}"

git clone --depth 1 --branch "${FLUTTER_VERSION}" https://github.com/flutter/flutter.git "$HOME/flutter"
export PATH="$HOME/flutter/bin:$PATH"

echo "Flutter version:"
flutter --version

# Disable analytics in CI
flutter config --no-analytics
dart --disable-analytics

# ─── Restore secret files from environment variables ───
echo "Restoring configuration files..."

# GoogleService-Info.plist (required for Firebase)
if [ -n "$GOOGLE_SERVICE_INFO" ]; then
    echo "$GOOGLE_SERVICE_INFO" | base64 --decode > ios/Runner/GoogleService-Info.plist
    echo "Restored GoogleService-Info.plist"
else
    echo "WARNING: GOOGLE_SERVICE_INFO not set. Firebase will not work."
fi

# .env file (required — listed as a Flutter asset in pubspec.yaml)
if [ -n "$ENV_FILE" ]; then
    echo "$ENV_FILE" | base64 --decode > .env
    echo "Restored .env"
else
    echo "WARNING: ENV_FILE not set. Creating empty .env to satisfy Flutter asset bundling."
    touch .env
fi

# environment.json (required — listed as a Flutter asset in pubspec.yaml)
mkdir -p assets/environment_values
if [ -n "$ENVIRONMENT_JSON" ]; then
    echo "$ENVIRONMENT_JSON" | base64 --decode > assets/environment_values/environment.json
    echo "Restored environment.json"
else
    echo "WARNING: ENVIRONMENT_JSON not set. Creating placeholder."
    echo '{"APIKEY":"","ClientSecrate":""}' > assets/environment_values/environment.json
fi

# ─── Install Flutter dependencies ───
echo "Installing Flutter dependencies..."
flutter pub get

# ─── Build Flutter for iOS ───
# flutter build ios runs pod install internally, no separate pod install needed
echo "Building Flutter iOS (release)..."
flutter build ios --release --no-codesign

echo "=== CI Post Clone Complete ==="
