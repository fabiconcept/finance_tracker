import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/api_client.dart';
import '../models/transaction.dart';
import '../models/summary.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final transactionsProvider =
    StateNotifierProvider<TransactionsNotifier, AsyncValue<List<Transaction>>>(
  (ref) => TransactionsNotifier(ref.read(apiClientProvider)),
);

final summaryProvider = StateNotifierProvider<SummaryNotifier, AsyncValue<Summary>>(
  (ref) => SummaryNotifier(ref.read(apiClientProvider)),
);

final filterProvider = StateProvider<String>((ref) => 'all');

final filteredTransactionsProvider = Provider<AsyncValue<List<Transaction>>>((ref) {
  final transactions = ref.watch(transactionsProvider);
  final filter = ref.watch(filterProvider);

  return transactions.when(
    data: (list) {
      if (filter == 'all') return AsyncValue.data(list);
      final filtered = list.where((t) => t.type == filter).toList();
      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

class TransactionsNotifier extends StateNotifier<AsyncValue<List<Transaction>>> {
  final ApiClient _apiClient;

  TransactionsNotifier(this._apiClient) : super(const AsyncValue.loading()) {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    state = const AsyncValue.loading();
    try {
      final response = await _apiClient.get('/transactions');
      final data = response['data'] as List;
      final transactions = data
          .map((json) => Transaction.fromJson(json as Map<String, dynamic>))
          .toList();
      transactions.sort((a, b) => b.date.compareTo(a.date));
      state = AsyncValue.data(transactions);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    try {
      await _apiClient.post('/transactions', transaction.toJson());
      await loadTransactions();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      await _apiClient.delete('/transactions/$id');
      await loadTransactions();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> updateTransaction(String id, Map<String, dynamic> updates) async {
    try {
      await _apiClient.patch('/transactions/$id', updates);
      await loadTransactions();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }
}

class SummaryNotifier extends StateNotifier<AsyncValue<Summary>> {
  final ApiClient _apiClient;

  SummaryNotifier(this._apiClient) : super(const AsyncValue.loading()) {
    loadSummary();
  }

  Future<void> loadSummary() async {
    state = const AsyncValue.loading();
    try {
      final response = await _apiClient.get('/summary');
      final summary = Summary.fromJson(response['data'] as Map<String, dynamic>);
      state = AsyncValue.data(summary);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
