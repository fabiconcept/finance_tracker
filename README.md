# Personal Finance Tracker

A modern Flutter mobile app for tracking personal income and expenses with a clean, intuitive interface.

![Flutter](https://img.shields.io/badge/Flutter-3.19+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.3+-0175C2?logo=dart)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green)

## Features

✅ **Transaction Management**
- Add income and expense transactions
- View all transactions sorted by date
- Filter by transaction type (All/Income/Expense)
- View detailed transaction information
- Delete transactions with confirmation

✅ **Financial Summary**
- Real-time net balance calculation
- Total income and expenses breakdown
- Visual summary cards with gradient design

✅ **Modern UI/UX**
- Clean, sleek Material Design 3 interface
- Smooth animations and transitions
- Pull-to-refresh functionality
- Loading and error states with retry options
- Empty states with helpful messages

✅ **Smart Features**
- Category autocomplete with suggestions
- Date picker for transaction dates
- Form validation
- Environment-based configuration

---

## Quick Start

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) **3.19 or higher**
- Dart 3.3+
- Android Studio or VS Code with Flutter extensions
- Android emulator or physical device (API level 21+)

Verify your setup:
```bash
flutter doctor
```

### 1. Run the Backend

The app requires a REST API backend. Ensure your backend is running on port 3333.

**Expected API endpoints:**
- `GET /transactions` - Get all transactions
- `GET /transactions/:id` - Get transaction by ID
- `POST /transactions` - Create transaction
- `PATCH /transactions/:id` - Update transaction
- `DELETE /transactions/:id` - Delete transaction
- `GET /summary` - Get financial summary

See `resource/api-endpoints.json` for complete API specification.

### 2. Configure Environment

Copy the environment template and configure your API URL:

```bash
cd finance_tracker
cp .env.example .env
```

Edit `.env` and set your backend URL:
```env
# For Android emulator
API_BASE_URL=http://10.0.2.2:3333

# For iOS simulator
API_BASE_URL=http://127.0.0.1:3333

# For physical device (use your computer's local IP)
API_BASE_URL=http://192.168.1.100:3333
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

```bash
# List available devices
flutter devices

# Run on connected device
flutter run

# Run on specific device
flutter run -d emulator-5554
```

---

## Project Structure

```
lib/
├── core/
│   ├── constants.dart          # App constants, categories
│   ├── api_client.dart         # HTTP client wrapper
│   └── theme.dart              # App theme and colors
├── models/
│   ├── transaction.dart        # Transaction data model
│   └── summary.dart            # Summary data model
├── providers/
│   └── transactions_provider.dart  # Riverpod state management
├── screens/
│   ├── home/
│   │   └── transactions_screen.dart    # Home screen
│   ├── add/
│   │   └── add_transaction_screen.dart # Add transaction
│   └── detail/
│       └── transaction_detail_screen.dart  # Transaction details
├── widgets/
│   ├── summary_card.dart           # Summary display card
│   ├── transaction_list_item.dart  # Transaction list item
│   ├── filter_tabs.dart            # Filter tabs widget
│   └── empty_state.dart            # Empty state widget
└── main.dart                       # App entry point
```

---

## Key Decisions & Trade-offs

### State Management: Riverpod

**Why Riverpod:**
- ✅ **Compile-safe** - Providers are top-level constants, no runtime errors
- ✅ **Testable** - Easy to override providers in tests
- ✅ **Async-first** - Built-in loading/error/data states with `AsyncValue`
- ✅ **No BuildContext dependency** - Can read state outside widgets
- ✅ **Better than Provider** - Riverpod is Provider's successor with improvements

**Alternatives considered:**
- **BLoC** - More boilerplate, better for very large teams
- **GetX** - Couples state/routing/DI, harder to reason about
- **Provider** - Riverpod is strictly better for new projects

### Navigation: GoRouter

**Why GoRouter:**
- ✅ **Declarative routing** - All routes defined in one place
- ✅ **Type-safe parameters** - Path parameters with validation
- ✅ **Official recommendation** - Flutter team's preferred solution
- ✅ **Deep linking ready** - Easy to add URL-based navigation

### API Client: Custom HTTP Wrapper

**Why custom wrapper:**
- ✅ **Simplicity** - Only need basic REST operations
- ✅ **Centralized error handling** - Consistent error messages
- ✅ **Easy to test** - Can inject mock client
- ✅ **No over-engineering** - Dio/Retrofit would be overkill for this scope

### Amount Storage: Integer (Kobo/Cents)

**Why integers:**
- ✅ **Precision** - Avoids floating-point rounding errors
- ✅ **Standard practice** - Same approach used by Stripe, PayPal
- ✅ **Simple conversion** - Divide by 100 for display

**Trade-off:** A production app would use a `Money` type with explicit currency.

### Client-side Filtering

**Why client-side:**
- ✅ **Instant response** - No API roundtrip for filter changes
- ✅ **Smooth UX** - Animated transitions between filters
- ✅ **Reduced server load** - Fewer API calls

**Trade-off:** With thousands of transactions, this should move to the API.

---

## What I'd Improve With More Time

### Features
- [ ] **Edit transaction screen** - UI for the PATCH endpoint
- [ ] **Search functionality** - Search transactions by title/category
- [ ] **Charts & analytics** - Spending trends with fl_chart
- [ ] **Budget goals** - Set and track spending limits
- [ ] **Recurring transactions** - Automated recurring entries
- [ ] **Export data** - CSV/PDF export
- [ ] **Multi-currency support** - Handle different currencies

### Technical Improvements
- [ ] **Offline support** - Local database with drift/hive
- [ ] **Unit tests** - Provider and model tests
- [ ] **Widget tests** - Screen interaction tests
- [ ] **Integration tests** - End-to-end flow tests
- [ ] **Pagination** - Infinite scroll for large lists
- [ ] **Optimistic updates** - Update UI before API response
- [ ] **Error retry logic** - Exponential backoff for failed requests

### UX Enhancements
- [ ] **Dark mode** - Complete dark theme
- [ ] **Biometric auth** - Fingerprint/Face ID
- [ ] **Notifications** - Spending alerts and reminders
- [ ] **Onboarding** - First-time user tutorial
- [ ] **Accessibility** - Screen reader support, larger text options

---

## Technical Stack

| Category | Technology | Version |
|----------|-----------|---------|
| Framework | Flutter | 3.19+ |
| Language | Dart | 3.3+ |
| State Management | Riverpod | 2.5.1 |
| Navigation | GoRouter | 13.2.0 |
| HTTP Client | http | 1.2.0 |
| Date Formatting | intl | 0.19.0 |
| Fonts | Google Fonts | 6.1.0 |
| Environment Config | flutter_dotenv | 5.1.0 |

---

## Error Handling

All screens implement comprehensive error handling:

**Loading States:**
- Skeleton loaders for summary cards
- Progress indicators with descriptive text
- Disabled buttons during async operations

**Error States:**
- User-friendly error messages
- Retry buttons for failed operations
- Snackbar notifications for actions
- Graceful degradation (summary fails independently from transactions)

**Validation:**
- Client-side form validation
- Real-time error feedback
- Required field indicators

---

## Environment Configuration

The app uses environment variables for configuration:

```env
API_BASE_URL=http://127.0.0.1:3333
```

**Setup:**
1. Copy `.env.example` to `.env`
2. Update `API_BASE_URL` for your environment
3. Restart the app

See `ENV_SETUP.md` for detailed configuration guide.

---

## Building for Release

### Android APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

---

## Troubleshooting

### Android Emulator Can't Connect to Backend

**Problem:** API calls fail with connection refused.

**Solution:** Use `10.0.2.2` instead of `localhost` in `.env`:
```env
API_BASE_URL=http://10.0.2.2:3333
```

### Physical Device Can't Connect

**Problem:** Device can't reach localhost.

**Solution:** Use your computer's local IP address:
```bash
# Find your IP (macOS/Linux)
ifconfig | grep "inet "

# Update .env
API_BASE_URL=http://192.168.1.100:3333
```

### Package Not Found Error

**Problem:** `flutter_dotenv` or other packages not found.

**Solution:**
```bash
flutter clean
flutter pub get
```

---

## Design Documentation

For detailed UI/UX design specifications, see:
- `resource/UI_DESIGN.md` - Complete design system documentation
- `resource/README_flutter.md` - Flutter app technical details

---

## License

This project is a take-home assessment and is not licensed for commercial use.

---

## Contact

For questions or issues, please refer to the project documentation or contact the development team.
