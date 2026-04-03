# Contributing to AASTU Students App v4

Thank you for your interest in contributing! This guide will help you get started.

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- A Firebase project (free tier works)
- Android Studio or VS Code with Flutter extensions

### Setup

1. **Fork and clone** the repository:
   ```sh
   git clone https://github.com/<your-username>/aastu-students-app-v4.git
   cd aastu-students-app-v4
   ```

2. **Set up environment files** by copying the example templates:
   ```sh
   cp .env.example .env
   cp android/app/google-services.json.example android/app/google-services.json
   cp ios/Runner/GoogleService-Info.plist.example ios/Runner/GoogleService-Info.plist
   cp assets/environment_values/environment.json.example assets/environment_values/environment.json
   ```

3. **Configure your Firebase project:**
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
   - Enable Authentication (Google Sign-In)
   - Enable Cloud Firestore
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) from Firebase Console
   - Place them in the appropriate directories (replacing the copies from step 2)
   - Fill in the `.env` file with your Firebase project values

4. **Fill in `assets/environment_values/environment.json`** with your own API keys.

5. **Install dependencies and run:**
   ```sh
   flutter pub get
   flutter run
   ```

## Development Workflow

1. Create a new branch from `main`:
   ```sh
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and test them locally.

3. Commit with clear, descriptive messages:
   ```sh
   git commit -m "Add: description of what you added"
   ```

4. Push and open a Pull Request against the `main` branch.

## Important Notes

- **Never commit secrets or API keys.** The `.gitignore` is configured to exclude sensitive files. If you see a secret in the codebase, please report it.
- Config files like `google-services.json`, `GoogleService-Info.plist`, `.env`, and `environment.json` are gitignored. Use the `.example` templates as reference.
- Keep PRs focused on a single feature or fix.
- Test on both Android and iOS if possible.

## Project Structure

```
lib/
  backend/       # Firebase, API, and backend logic
  components/    # Reusable UI components
  pages/         # App screens/pages
  flutter_flow/  # FlutterFlow generated utilities
assets/          # Images, fonts, and config files
android/         # Android-specific configuration
ios/             # iOS-specific configuration
scripts/         # Utility scripts for data population
```

## Reporting Issues

- Use GitHub Issues to report bugs or request features.
- Include steps to reproduce, expected behavior, and screenshots if applicable.

## Code of Conduct

Be respectful and constructive. We're all here to make the AASTU experience better for students.
