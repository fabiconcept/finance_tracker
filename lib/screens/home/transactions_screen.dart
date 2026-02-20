import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../providers/transactions_provider.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/transaction_list_item.dart';
import '../../widgets/filter_tabs.dart';
import '../../widgets/empty_state.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(summaryProvider);
    final transactionsAsync = ref.watch(filteredTransactionsProvider);
    final selectedFilter = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.read(transactionsProvider.notifier).loadTransactions();
              ref.read(summaryProvider.notifier).loadSummary();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(transactionsProvider.notifier).loadTransactions();
          await ref.read(summaryProvider.notifier).loadSummary();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: summaryAsync.when(
                data: (summary) => SummaryCard(
                  totalIncome: summary.totalIncome,
                  totalExpenses: summary.totalExpenses,
                  netBalance: summary.netBalance,
                ),
                loading: () => Container(
                  margin: const EdgeInsets.all(16),
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, _) => Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: AppTheme.primaryRed,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Failed to load summary',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.primaryRed,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: FilterTabs(
                selectedFilter: selectedFilter,
                onFilterChanged: (filter) {
                  ref.read(filterProvider.notifier).state = filter;
                },
              ),
            ),
            transactionsAsync.when(
              data: (transactions) {
                if (transactions.isEmpty) {
                  return SliverFillRemaining(
                    child: EmptyState(
                      message: selectedFilter == 'all'
                          ? 'No transactions yet.\nTap + to add your first transaction.'
                          : 'No ${selectedFilter} transactions found.',
                      icon: selectedFilter == 'all'
                          ? Icons.inbox_rounded
                          : Icons.filter_list_off_rounded,
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(top: 8, bottom: 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final transaction = transactions[index];
                        return TransactionListItem(
                          transaction: transaction,
                          onTap: () {
                            context.push('/transaction/${transaction.id}');
                          },
                        );
                      },
                      childCount: transactions.length,
                    ),
                  ),
                );
              },
              loading: () => SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        'Loading transactions...',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              error: (error, stack) => SliverFillRemaining(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 64,
                          color: AppTheme.primaryRed,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Failed to load transactions',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppTheme.textPrimary,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          error.toString(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            ref.read(transactionsProvider.notifier).loadTransactions();
                          },
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/add');
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Transaction'),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
      ),
    );
  }
}
