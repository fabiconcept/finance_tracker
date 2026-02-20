import 'package:flutter_dotenv/flutter_dotenv.dart';

String get kBaseUrl => dotenv.env['API_BASE_URL'] ?? 'http://127.0.0.1:3333';

const List<String> kIncomeCategories = [
  'Salary',
  'Freelance',
  'Investment',
  'Business',
  'Gift',
  'Other Income',
];

const List<String> kExpenseCategories = [
  'Food',
  'Transport',
  'Shopping',
  'Bills',
  'Entertainment',
  'Healthcare',
  'Education',
  'Other Expense',
];
