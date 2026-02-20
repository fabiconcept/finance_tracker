class Summary {
  final int totalIncome;
  final int totalExpenses;
  final int netBalance;
  final TransactionCount transactionCount;

  Summary({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netBalance,
    required this.transactionCount,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      totalIncome: json['total_income'] as int,
      totalExpenses: json['total_expenses'] as int,
      netBalance: json['net_balance'] as int,
      transactionCount: TransactionCount.fromJson(
        json['transaction_count'] as Map<String, dynamic>,
      ),
    );
  }

  factory Summary.empty() {
    return Summary(
      totalIncome: 0,
      totalExpenses: 0,
      netBalance: 0,
      transactionCount: TransactionCount(income: 0, expense: 0, total: 0),
    );
  }
}

class TransactionCount {
  final int income;
  final int expense;
  final int total;

  TransactionCount({
    required this.income,
    required this.expense,
    required this.total,
  });

  factory TransactionCount.fromJson(Map<String, dynamic> json) {
    return TransactionCount(
      income: json['income'] as int,
      expense: json['expense'] as int,
      total: json['total'] as int,
    );
  }
}
