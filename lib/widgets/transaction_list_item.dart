import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/theme.dart';
import '../models/transaction.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback onTap;

  const TransactionListItem({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  String _formatAmount(int amount) {
    final formatter = NumberFormat.currency(
      symbol: '₦',
      decimalDigits: 0,
    );
    return formatter.format(amount / 100);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'Today, ${DateFormat('HH:mm').format(date)}';
    } else if (transactionDate == yesterday) {
      return 'Yesterday, ${DateFormat('HH:mm').format(date)}';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  IconData _getCategoryIcon(String category) {
    final categoryLower = category.toLowerCase();
    if (categoryLower.contains('salary') || categoryLower.contains('income')) {
      return Icons.account_balance_wallet_rounded;
    } else if (categoryLower.contains('food')) {
      return Icons.restaurant_rounded;
    } else if (categoryLower.contains('transport')) {
      return Icons.directions_car_rounded;
    } else if (categoryLower.contains('shopping')) {
      return Icons.shopping_bag_rounded;
    } else if (categoryLower.contains('bill')) {
      return Icons.receipt_long_rounded;
    } else if (categoryLower.contains('entertainment')) {
      return Icons.movie_rounded;
    } else if (categoryLower.contains('health')) {
      return Icons.local_hospital_rounded;
    } else if (categoryLower.contains('education')) {
      return Icons.school_rounded;
    } else if (categoryLower.contains('freelance') || categoryLower.contains('business')) {
      return Icons.work_rounded;
    } else if (categoryLower.contains('investment')) {
      return Icons.trending_up_rounded;
    } else if (categoryLower.contains('gift')) {
      return Icons.card_giftcard_rounded;
    }
    return transaction.isIncome ? Icons.add_circle_rounded : Icons.remove_circle_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final color = transaction.isIncome ? AppTheme.incomeColor : AppTheme.expenseColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getCategoryIcon(transaction.category),
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            transaction.category,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: color,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatDate(transaction.date),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${transaction.isIncome ? '+' : '-'}${_formatAmount(transaction.amount)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
