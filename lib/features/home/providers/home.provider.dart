import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentaura_app/features/home/models/quotes.model.dart';
import 'package:mentaura_app/features/home/repositories/quotes.repository.dart';

final quoteRepositoryProvider = Provider<QuotesRepository>((ref) {
  return QuotesRepository();
});

final quotesProvider = FutureProvider<QuotesModel?>((ref) async {
  final repo = ref.read(quoteRepositoryProvider);
  return repo.getDailyQuotes();
});
