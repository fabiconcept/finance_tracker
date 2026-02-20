# Environment Configuration Setup

## Overview

The Finance Tracker app now uses environment variables for configuration, making it easy to switch between different environments (development, staging, production) without modifying code.

## Files Created

### 1. `.env` (Git-ignored)
Contains your actual environment variables. **This file is not committed to version control.**

```env
API_BASE_URL=http://127.0.0.1:3333
```

### 2. `.env.example` (Committed to Git)
Template file showing required environment variables. Team members copy this to create their own `.env` file.

```env
# API Configuration
# Copy this file to .env and update with your actual values

# Backend API Base URL
# For Android emulator: http://10.0.2.2:3333
# For iOS simulator: http://127.0.0.1:3333
# For physical device: http://YOUR_LOCAL_IP:3333
API_BASE_URL=http://127.0.0.1:3333
```

## Setup Instructions

### For New Team Members

1. **Copy the example file:**
   ```bash
   cp .env.example .env
   ```

2. **Update `.env` with your configuration:**
   - For **Android emulator**: `API_BASE_URL=http://10.0.2.2:3333`
   - For **iOS simulator**: `API_BASE_URL=http://127.0.0.1:3333`
   - For **physical device**: `API_BASE_URL=http://YOUR_LOCAL_IP:3333`

3. **Run the app:**
   ```bash
   flutter pub get
   flutter run
   ```

## How It Works

### 1. Package Used
- **flutter_dotenv** (`^5.1.0`) - Loads environment variables from `.env` file

### 2. Loading Environment Variables
In `lib/main.dart`:
```dart
Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const ProviderScope(child: MyApp()));
}
```

### 3. Accessing Variables
In `lib/core/constants.dart`:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

String get kBaseUrl => dotenv.env['API_BASE_URL'] ?? 'http://127.0.0.1:3333';
```

The `??` operator provides a fallback value if the environment variable is not set.

## Different Environments

### Development (Local Backend)
```env
API_BASE_URL=http://127.0.0.1:3333
```

### Staging
```env
API_BASE_URL=https://staging-api.yourapp.com
```

### Production
```env
API_BASE_URL=https://api.yourapp.com
```

## Security Best Practices

✅ **DO:**
- Keep `.env` in `.gitignore`
- Commit `.env.example` with dummy/example values
- Document all required environment variables
- Use different values for different environments
- Never hardcode sensitive data in code

❌ **DON'T:**
- Commit `.env` file to version control
- Share `.env` files via insecure channels
- Use production credentials in development
- Hardcode API keys or secrets

## Troubleshooting

### Error: "Unable to load asset: .env"
**Solution:** Make sure `.env` file exists in the project root:
```bash
cp .env.example .env
```

### Error: "API_BASE_URL is null"
**Solution:** Check that your `.env` file contains:
```env
API_BASE_URL=http://127.0.0.1:3333
```

### Android Emulator Can't Connect
**Solution:** Use `10.0.2.2` instead of `127.0.0.1`:
```env
API_BASE_URL=http://10.0.2.2:3333
```

### Physical Device Can't Connect
**Solution:** Use your computer's local IP address:
```bash
# Find your IP (macOS/Linux)
ifconfig | grep "inet "

# Update .env
API_BASE_URL=http://192.168.1.100:3333
```

## Adding New Environment Variables

1. **Add to `.env`:**
   ```env
   API_BASE_URL=http://127.0.0.1:3333
   API_TIMEOUT=30000
   ENABLE_LOGGING=true
   ```

2. **Add to `.env.example`:**
   ```env
   API_BASE_URL=http://127.0.0.1:3333
   API_TIMEOUT=30000
   ENABLE_LOGGING=true
   ```

3. **Access in code:**
   ```dart
   String get apiTimeout => dotenv.env['API_TIMEOUT'] ?? '30000';
   bool get enableLogging => dotenv.env['ENABLE_LOGGING'] == 'true';
   ```

## CI/CD Integration

For automated builds, create environment variables in your CI/CD platform:

### GitHub Actions
```yaml
- name: Create .env file
  run: |
    echo "API_BASE_URL=${{ secrets.API_BASE_URL }}" > .env
```

### GitLab CI
```yaml
before_script:
  - echo "API_BASE_URL=$API_BASE_URL" > .env
```

## Files Modified

- ✅ `pubspec.yaml` - Added `flutter_dotenv: ^5.1.0`
- ✅ `lib/main.dart` - Load `.env` file on app start
- ✅ `lib/core/constants.dart` - Use environment variables
- ✅ `.gitignore` - Exclude `.env` from version control
- ✅ `.env` - Created (git-ignored)
- ✅ `.env.example` - Created (committed)

## Summary

Your app now has a professional environment configuration setup that:
- ✅ Keeps sensitive data out of version control
- ✅ Makes it easy to switch between environments
- ✅ Follows industry best practices
- ✅ Works seamlessly with CI/CD pipelines
- ✅ Provides clear documentation for team members
