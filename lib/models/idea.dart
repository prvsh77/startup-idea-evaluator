class Idea {
  final String id;
  final String name;
  final String tagline;
  final String description;
  final int rating;
  final int votes;
  final DateTime createdAt;
  final String? category;

  Idea({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.rating,
    required this.votes,
    required this.createdAt,
    this.category,
  });

  Idea copyWith({
    String? id,
    String? name,
    String? tagline,
    String? description,
    int? rating,
    int? votes,
    DateTime? createdAt,
    String? category,
  }) {
    return Idea(
      id: id ?? this.id,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      votes: votes ?? this.votes,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
    );
  }
}
