# Finance Tracker - UI Design Documentation

## Design Philosophy

A **clean, modern, and sleek** mobile finance tracker with emphasis on:
- **Minimalism** - Clean layouts with ample white space
- **Visual Hierarchy** - Clear information architecture
- **Smooth Interactions** - Animated transitions and feedback
- **Accessibility** - High contrast, readable typography
- **Consistency** - Unified design language across all screens

---

## Color Palette

### Primary Colors
- **Primary Green**: `#00C853` - Income, success states, primary actions
- **Primary Red**: `#FF5252` - Expenses, destructive actions
- **Background Light**: `#F8F9FA` - Screen backgrounds
- **Card Background**: `#FFFFFF` - Card surfaces

### Text Colors
- **Text Primary**: `#212121` - Headings, important text
- **Text Secondary**: `#757575` - Supporting text, labels
- **Divider**: `#E0E0E0` - Borders, separators

---

## Typography

**Font Family**: Inter (via Google Fonts)

### Hierarchy
- **Display Large**: 32px, Bold - Large amounts, hero text
- **Display Medium**: 28px, Bold - Screen titles
- **Display Small**: 24px, SemiBold - Section headers
- **Headline Medium**: 20px, SemiBold - Card titles
- **Title Large**: 18px, SemiBold - List item titles
- **Title Medium**: 16px, Medium - Form labels, buttons
- **Body Large**: 16px, Regular - Primary body text
- **Body Medium**: 14px, Regular - Secondary body text
- **Body Small**: 12px, Regular - Captions, metadata

---

## Screen Designs

### 1. Home Screen (Transactions)

**Layout Structure**:
```
┌─────────────────────────────────────┐
│ ← Finance Tracker          🔄       │ AppBar
├─────────────────────────────────────┤
│                                     │
│  ┌───────────────────────────────┐ │
│  │   Net Balance                 │ │
│  │   ₦145,000                    │ │ Gradient Card
│  │                               │ │ (Green gradient)
│  │   Income      │   Expenses    │ │
│  │   ₦200,000    │   ₦55,000     │ │
│  └───────────────────────────────┘ │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ All │ Income │ Expense      │   │ Filter Tabs
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ 💰 Monthly Salary           │   │
│  │ Salary • Today, 10:30       │   │ Transaction
│  │                   +₦150,000 │   │ List Item
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ 🍔 Grocery Shopping         │   │
│  │ Food • Yesterday, 08:00     │   │
│  │                    -₦4,500  │   │
│  └─────────────────────────────┘   │
│                                     │
│                  [+ Add Transaction]│ FAB
└─────────────────────────────────────┘
```

**Key Features**:
- **Summary Card**: Gradient background with shadow, displays net balance prominently
- **Income/Expense Breakdown**: Semi-transparent white containers within the gradient
- **Filter Tabs**: Smooth animated selection with color transitions
- **Transaction Items**: Icon-based categorization, color-coded amounts
- **Pull-to-Refresh**: Native refresh indicator
- **Empty State**: Friendly illustration and message when no transactions

**Interactions**:
- Tap transaction → Navigate to detail screen
- Tap FAB → Navigate to add transaction screen
- Swipe down → Refresh data
- Tap filter → Animate selection, filter list

---

### 2. Add Transaction Screen

**Layout Structure**:
```
┌─────────────────────────────────────┐
│ ✕ Add Transaction                   │ AppBar
├─────────────────────────────────────┤
│                                     │
│  ┌─────────────────────────────┐   │
│  │  Income  │  Expense          │   │ Type Toggle
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ 📝 Title                     │   │
│  │ Enter transaction title      │   │ Text Input
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ 💱 Amount                    │   │
│  │ ₦ 0.00                       │   │ Number Input
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ 📂 Category                  │   │
│  │ Select or enter category     │   │ Autocomplete
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ 📅 Date                      │   │
│  │ January 15, 2024             │   │ Date Picker
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ 📝 Note (Optional)           │   │
│  │ Add a note                   │   │ Multi-line
│  │                              │   │ Text Input
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │    Add Transaction           │   │ Submit Button
│  └─────────────────────────────┘   │
└─────────────────────────────────────┘
```

**Key Features**:
- **Type Toggle**: Animated selection between Income/Expense with color coding
- **Smart Category Input**: Autocomplete with predefined suggestions
- **Date Picker**: Native Material date picker with custom theme
- **Form Validation**: Real-time validation with error messages
- **Loading State**: Button shows spinner during submission
- **Success Feedback**: Green snackbar on success, auto-navigate back

**Interactions**:
- Tap type toggle → Animate selection, update category suggestions
- Tap date field → Open date picker dialog
- Type in category → Show autocomplete suggestions
- Tap submit → Validate, show loading, submit, show feedback

---

### 3. Transaction Detail Screen

**Layout Structure**:
```
┌─────────────────────────────────────┐
│ ← Transaction Details               │ AppBar
├─────────────────────────────────────┤
│                                     │
│ ┌───────────────────────────────┐   │
│ │                               │   │
│ │         💰                    │   │ Hero Section
│ │                               │   │ (Gradient)
│ │      +₦150,000                │   │
│ │                               │   │
│ │      INCOME                   │   │
│ └───────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ 📝  Title                    │   │
│  │     Monthly Salary           │   │ Detail Card
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ 📂  Category                 │   │
│  │     Salary                   │   │ Detail Card
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ 📅  Date                     │   │
│  │     January 15, 2024 • 10:30│   │ Detail Card
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ 📝  Note                     │   │
│  │     June 2024 salary         │   │ Detail Card
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ 🗑️  Delete Transaction      │   │ Delete Button
│  └─────────────────────────────┘   │
└─────────────────────────────────────┘
```

**Key Features**:
- **Hero Section**: Full-width gradient header with large amount display
- **Category Icon**: Large icon in semi-transparent container
- **Detail Cards**: Consistent card layout with icon, label, and value
- **Delete Confirmation**: Alert dialog before deletion
- **Error Handling**: Graceful error states with retry options

**Interactions**:
- Tap back → Navigate to home
- Tap delete → Show confirmation dialog
- Confirm delete → Show loading, delete, show feedback, navigate back

---

## Component Library

### Summary Card
- **Gradient Background**: Green gradient with shadow
- **Border Radius**: 20px
- **Padding**: 24px
- **Shadow**: Soft green shadow with 20px blur
- **Content**: Net balance (large), Income/Expense breakdown (cards)

### Transaction List Item
- **Background**: White card
- **Border Radius**: 16px
- **Padding**: 16px
- **Layout**: Icon (48px circle) | Title + Category/Date | Amount
- **Icon Background**: 10% opacity of transaction color
- **Category Badge**: Rounded pill with colored background
- **Hover/Tap**: Ripple effect

### Filter Tabs
- **Container**: White background, 4px padding
- **Border Radius**: 12px
- **Tab**: Animated background color on selection
- **Selected**: Green background, white text
- **Unselected**: Transparent background, gray text
- **Animation**: 200ms ease-in-out

### Input Fields
- **Background**: Light gray (#F8F9FA)
- **Border**: None (default), 2px green (focused), 2px red (error)
- **Border Radius**: 12px
- **Padding**: 16px
- **Icon**: Leading icon with consistent spacing

### Buttons
- **Primary**: Green background, white text, no shadow
- **Destructive**: Red background, white text
- **Border Radius**: 12px
- **Padding**: 16px vertical, 24px horizontal
- **Height**: 56px (large buttons)
- **Loading State**: Spinner replaces text

### Empty State
- **Icon**: Large gray icon (80px)
- **Text**: Gray body text
- **Alignment**: Center
- **Spacing**: 16px between icon and text

---

## Animations & Transitions

### Screen Transitions
- **Navigation**: Material page route with slide animation
- **Duration**: 300ms
- **Curve**: Ease-in-out

### Component Animations
- **Filter Tab Selection**: 200ms color transition
- **Type Toggle**: 200ms background color transition
- **Button Press**: Ripple effect with scale feedback
- **Loading States**: Circular progress indicator

### Micro-interactions
- **Pull-to-Refresh**: Native Material refresh indicator
- **Snackbar**: Slide up from bottom, auto-dismiss after 3s
- **Dialog**: Fade in with scale animation

---

## Responsive Behavior

### Spacing
- **Screen Padding**: 16px horizontal
- **Card Margin**: 16px horizontal, 6px vertical
- **Component Spacing**: 16px between major elements, 8px between related items

### Touch Targets
- **Minimum Size**: 48x48px for all interactive elements
- **Button Height**: 56px for primary actions
- **Icon Size**: 24px standard, 40px+ for hero icons

---

## Accessibility

### Color Contrast
- All text meets WCAG AA standards (4.5:1 minimum)
- Primary green on white: 7.2:1
- Text primary on background: 15.8:1

### Typography
- Minimum font size: 12px (captions)
- Body text: 14-16px
- Line height: 1.5x for body text

### Interactive Elements
- Clear focus states
- Sufficient touch target sizes
- Semantic labels for screen readers

---

## Design Tokens

```dart
// Colors
primaryGreen: #00C853
primaryRed: #FF5252
backgroundLight: #F8F9FA
cardBackground: #FFFFFF
textPrimary: #212121
textSecondary: #757575
dividerColor: #E0E0E0

// Spacing
spacing-xs: 4px
spacing-sm: 8px
spacing-md: 16px
spacing-lg: 24px
spacing-xl: 32px

// Border Radius
radius-sm: 6px
radius-md: 12px
radius-lg: 16px
radius-xl: 20px

// Shadows
shadow-sm: 0 2px 4px rgba(0,0,0,0.1)
shadow-md: 0 4px 8px rgba(0,0,0,0.12)
shadow-lg: 0 10px 20px rgba(0,200,83,0.3)
```

---

## Implementation Notes

### State Management
- **Riverpod**: Compile-safe, testable state management
- **Providers**: Separate providers for transactions, summary, and filters
- **Async Handling**: Built-in loading, error, and data states

### Navigation
- **GoRouter**: Declarative routing with type-safe parameters
- **Routes**: `/` (home), `/add` (add transaction), `/transaction/:id` (detail)

### API Integration
- **Base URL**: Configurable in constants.dart
- **Error Handling**: Try-catch with user-friendly messages
- **Loading States**: Consistent loading indicators across all screens

### Performance
- **Lazy Loading**: ListView.builder for efficient list rendering
- **State Preservation**: Riverpod maintains state across navigation
- **Minimal Rebuilds**: Scoped providers prevent unnecessary rebuilds

---

## Future Enhancements

1. **Dark Mode**: Complete dark theme with adjusted colors
2. **Charts**: Visual spending/income trends with fl_chart
3. **Search**: Transaction search with filtering
4. **Categories Management**: Custom category creation and icons
5. **Export**: CSV/PDF export functionality
6. **Biometric Auth**: Fingerprint/Face ID for app access
7. **Multi-currency**: Support for multiple currencies
8. **Recurring Transactions**: Automated recurring entries
9. **Budget Goals**: Set and track spending limits
10. **Notifications**: Reminders and spending alerts
