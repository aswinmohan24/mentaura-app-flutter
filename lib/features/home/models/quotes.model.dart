class QuotesModel {
  final String quote;
  final String author;
  QuotesModel({
    required this.quote,
    required this.author,
  });

  factory QuotesModel.fromMap(Map<String, dynamic> map) {
    return QuotesModel(
      quote: map['q'] as String,
      author: map['a'] as String,
    );
  }
}
