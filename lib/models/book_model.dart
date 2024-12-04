class Books {
  final String title;
  final String id;
  final String tahunTerbit;
  final String authorName;
  final String cover;
  final String review;
  final String sinopsis;

  Books({required this.title, required this.id, required this.tahunTerbit, required this.authorName, required this.cover, required this.review, required this.sinopsis});

  factory Books.fromJson(Map<String, dynamic> json) {
  return Books(
    title: json['title'] ?? 'Unknown Title',
    id: json['id'] ?? '',
    tahunTerbit: json['tahunTerbit'] ?? '',
    authorName: json['authorName'] ?? '',
    cover: json['cover'] ?? '',
    review: json['review'] ?? '',
    sinopsis: json['sinopsis'] ?? '',
  );
}
}
