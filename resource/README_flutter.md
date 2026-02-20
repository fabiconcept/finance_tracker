# Personal Finance Tracker — Flutter App

A Flutter mobile app that lets users log, view, and manage personal income and expense transactions. Consumes the companion REST API.

---

## Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install) **3.19 or higher**
- Dart 3.3+
- Android Studio or VS Code with Flutter/Dart extensions
- An Android emulator or physical Android device (API level 21+)
- The backend API running locally (see [backend README](../backend/README.md))

Verify your setup:

```bash
flutter doctor
```

All items should pass (Android toolchain is required; iOS is optional).

---

## Setup & Run

```bash
# 1. Navigate to the Flutter app directory
cd finance_tracker

# 2. Get dependencies
flutter pub get

# 3. Confirm a device is connected
flutter devices

# 4. Run the app
flutter run
```

To run on a specific device:

```bash
flutter run -d emulator-5554      # Android emulator
flutter run -d <device-id>        # Physical device
```

### Configuring the API Base URL

The base URL is set in `lib/core/constants.dart`:

```dart
const String kBaseUrl = 'http://10.0.2.2:8080';
```

| Scenario | URL to use |
|----------|-----------|
| Android emulator → localhost | `http://10.0.2.2:8080` |
| Physical device (same Wi-Fi) | `http://192.168.x.x:8080` (your machine's local IP) |
| iOS simulator → localhost | `http://127.0.0.1:8080` |

> **Note:** `10.0.2.2` is the Android emulator's alias for your host machine's localhost. Change this if running on a physical device.

---

## Build a Release APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

---

## Project Structure

```
lib/
├── core/
│   ├── constants.dart          # Base URL, app-wide constants
│   └── api_client.dart         # HTTP client wrapper
├── models/
│   ├── transaction.dart        # Transaction data model
│   └── summary.dart            # Summary data model
├── providers/
│   └── transactions_provider.dart  # Riverpod state management
├── screens/
│   ├── home/
│   │   └── transactions_screen.dart
│   ├── add/
│   │   └── add_transaction_screen.dart
│   └── detail/
│       └── transaction_detail_screen.dart
├── widgets/
│   ├── summary_bar.dart
│   ├── transaction_list_item.dart
│   └── filter_tabs.dart
└── main.dart
```

---

## Screens

### 1. Transactions (Home)
- Fetches all transactions and summary on load
- Summary bar at the top: net balance, total income, total expenses
- Transaction list sorted newest first
- Filter tabs: All / Income / Expense (client-side, no extra API call)
- Loading spinner while fetching; error message on failure
- Empty state when no transactions match the filter
- FAB navigates to Add Transaction screen
- Tap any item to open Transaction Detail screen

### 2. Add Transaction
- Form fields: Title, Amount, Type (Income / Expense), Category, Date, Note (optional)
- Client-side validation on all required fields before submission
- Date picker for the date field
- Submit button disabled and loading indicator shown during API call
- On success: navigates back to home, list refreshes automatically
- On failure: error snackbar with the API's message

### 3. Transaction Detail
- Displays all fields for the selected transaction
- Delete button opens a confirmation dialog before calling the API
- On confirmed delete: navigates back to home, list refreshes
- Error snackbar if the delete call fails

---

## State Management — Riverpod

**Choice:** [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)

**Why Riverpod:**
- Compile-safe — providers are declared as top-level constants, no runtime `context.read` lookup errors
- Easy to test — providers can be overridden in tests without a widget tree
- Async support is first-class (`AsyncNotifier`, `FutureProvider`) — loading and error states are built in, not bolted on
- No `BuildContext` dependency for reading state outside widgets

**Why not alternatives:**
- *Provider* — Riverpod is its spiritual successor; strictly better for new projects
- *BLoC* — more boilerplate than needed for this scope; better suited to very large teams
- *GetX* — couples state, routing, and DI in ways that make the codebase harder to reason about

---

## Navigation — GoRouter

**Choice:** [go_router](https://pub.dev/packages/go_router)

**Why GoRouter:**
- Declarative route definitions in one place — easy to audit and extend
- Handles back-stack correctly on Android (back button behaviour)
- Official Flutter team recommendation for production apps

**Routes defined:**

| Path | Screen |
|------|--------|
| `/` | Transactions (Home) |
| `/add` | Add Transaction |
| `/transaction/:id` | Transaction Detail |

---

## Key Packages

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_riverpod` | ^2.5.x | State management |
| `go_router` | ^13.x | Navigation |
| `http` | ^1.2.x | API calls |
| `intl` | ^0.19.x | Date formatting |

All packages are from [pub.dev](https://pub.dev). No unpublished or forked dependencies.

---

## Decisions & Trade-offs

**Amount is stored as a plain number (no currency library):** For this scope, integer values representing the smallest currency unit (e.g. kobo/cents) or plain doubles are fine. A real app would use a `Money` type with explicit currency to avoid floating-point rounding.

**Client-side filtering and sorting:** The API returns all transactions and filtering (All / Income / Expense) and sorting (newest first) are done in the provider layer. This avoids extra API roundtrips for simple state changes and keeps the UI responsive. With thousands of records this would need to move to the API level.

**Categories are free-text:** No hardcoded category list is enforced. The form provides a text field. An autocomplete with common categories (Food, Salary, Transport, etc.) would improve UX — noted as a future improvement.

**No edit screen:** The PATCH endpoint exists in the API but an edit transaction screen is not included in the Flutter app. The spec focused on log, view, and delete; editing was not listed as a required screen.

**Error handling via SnackBar:** All network errors surface through a consistent SnackBar at the bottom of the screen. Persistent errors (e.g. home screen fetch failure) additionally show an inline retry button.

---

## What I'd Improve With More Time

- Edit transaction screen (UI for the PATCH endpoint)
- Persistent local cache with `drift` or `hive` so the app works offline
- Pull-to-refresh on the home screen
- Category autocomplete / predefined suggestions
- Unit tests for providers and widget tests for all three screens
- Currency formatting with locale awareness
- Dark mode support
- iOS build verification and TestFlight distribution
- Pagination / infinite scroll for large transaction lists
