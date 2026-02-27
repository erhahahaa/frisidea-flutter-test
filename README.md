# Pencatatan Keuangan

A simple and intuitive financial tracking application built with Flutter. Track your income and expenses, view your balance, and filter transactions with ease.

## Features

- **Transaction Management**
  - Add income and expense transactions
  - Each transaction includes description, category, amount, and date
  - Swipe-to-delete with confirmation dialog
  - Pull-to-refresh to reload data

- **Balance Overview**
  - View total balance (income - expense)
  - See total income and total expense at a glance
  - Color-coded display (green for income, red for expense)

- **Smart Filtering**
  - Filter transactions by date range
  - Filter by category
  - Filter by transaction type (Income/Expense)
  - Combine multiple filters
  - Active filter indicator

- **Local Data Storage**
  - SQLite database for persistent storage
  - Data remains available offline
  - Fast and efficient queries

- **Predefined Categories**
  - **Income:** Salary, Business, Other
  - **Expense:** Food, Transport, Bills, Shopping, Entertainment, Other

- **Material Design 3**
  - Modern and clean UI
  - Responsive design
  - Smooth animations and transitions

## Screenshots

*Screenshots will be added here*

## Prerequisites

- Flutter SDK (3.10.4 or higher)
- Dart SDK (included with Flutter)
- Android Studio / VS Code (recommended)
- Android/iOS device or emulator

## Installation

1. Clone the repository:
```bash
git clone git@github.com:erhahahaa/frisidea-flutter-test.git
cd frisidea_flutter_test
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Usage

### Adding a Transaction

1. Tap the floating action button (+) on the home screen
2. Select transaction type (Income or Expense)
3. Enter description
4. Select category from dropdown
5. Enter amount (in Indonesian Rupiah)
6. Select date (defaults to today)
7. Tap "Save Transaction"

### Viewing Balance

The home screen displays:
- Total Balance at the top
- Total Income (green, with down arrow icon)
- Total Expense (red, with up arrow icon)

### Filtering Transactions

1. Tap the filter icon in the app bar
2. Select date range (optional)
3. Choose transaction type: All, Income, or Expense (optional)
4. Select category (optional)
5. Tap "Apply Filters"
6. Tap "Reset" to clear all filters

### Deleting a Transaction

1. Swipe left on any transaction
2. Confirm deletion in the dialog
3. Transaction will be removed from the database

## Project Structure

```
lib/
├── main.dart                          # App entry point with Material 3 theme
├── models/
│   └── transaction.dart               # Transaction data model
├── database/
│   └── database_helper.dart           # SQLite database operations
├── screens/
│   ├── home_screen.dart              # Main screen with transaction list
│   ├── add_transaction_screen.dart   # Form to add transactions
│   └── filter_screen.dart            # Filter transactions screen
├── widgets/
│   ├── balance_card.dart             # Balance summary widget
│   └── transaction_card.dart         # Individual transaction card
└── utils/
    └── constants.dart                # App constants and formatters
```

## Technologies Used

- **Flutter** - UI framework
- **Dart** - Programming language
- **sqflite** (^2.4.2) - SQLite database
- **path_provider** (^2.1.5) - File path resolution
- **intl** (^0.20.2) - Date and currency formatting
- **Material Design 3** - Design system

## Development

### Running Tests

```bash
flutter test
```

### Code Analysis

```bash
flutter analyze
```

### Code Formatting

```bash
dart format .
```

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

## Database Schema

```sql
CREATE TABLE transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  description TEXT NOT NULL,
  category TEXT NOT NULL,
  amount REAL NOT NULL,
  type TEXT NOT NULL,  -- 'income' or 'expense'
  date TEXT NOT NULL   -- ISO 8601 format
)
```

## Features in Detail

### Transaction Model

The `Transaction` class includes:
- `id`: Unique identifier (auto-generated)
- `description`: Transaction description (max 100 characters)
- `category`: Selected category
- `amount`: Transaction amount (must be > 0)
- `type`: Income or Expense (enum)
- `date`: Transaction date

### Database Operations

The `DatabaseHelper` singleton provides:
- `insertTransaction()` - Add new transaction
- `getTransactions()` - Get all transactions
- `updateTransaction()` - Update existing transaction
- `deleteTransaction()` - Remove transaction
- `getFilteredTransactions()` - Filter by date/category/type
- `getTotalIncome()` - Calculate total income
- `getTotalExpense()` - Calculate total expense
- `getBalance()` - Calculate balance

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes using conventional commits
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Commit Message Format

We follow the Conventional Commits specification:

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design system
- sqflite package maintainers

## Support

For issues, questions, or suggestions, please open an issue on GitHub.
