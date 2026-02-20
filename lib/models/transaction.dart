class Transaction {
  final String id;
  final String title;
  final int amount;
  final String type;
  final String category;
  final DateTime date;
  final String? note;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.note,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      title: json['title'] as String,
      amount: json['amount'] as int,
      type: json['type'] as String,
      category: json['category'] as String,
      date: DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'type': type,
      'category': category,
      'date': date.toIso8601String(),
      if (note != null && note!.isNotEmpty) 'note': note,
    };
  }

  bool get isIncome => type == 'income';
  bool get isExpense => type == 'expense';
}
