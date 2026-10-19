class Recipe {
  final int id;
  final String name;
  final String category;
  final String emoji;
  final int duration;
  final int servings;
  final String level;
  final double rating;
  final String description;
  final List<String> ingredients;
  final List<String> steps;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.emoji,
    required this.duration,
    required this.servings,
    required this.level,
    required this.rating,
    required this.description,
    required this.ingredients,
    required this.steps,
  });

  // Dipakai saat membaca JSON lokal, dan nanti juga untuk respons API.
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      emoji: json['emoji'],
      duration: json['duration'],
      servings: json['servings'],
      level: json['level'],
      rating: (json['rating'] as num).toDouble(),
      description: json['description'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
    );
  }
}