import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: kMint,
  surfaceTintColor: Colors.transparent,
  scrolledUnderElevation: 0,
  elevation: 0,
  leading: const BackButton(color: kText),
),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        children: [
          // Ilustrasi emoji besar
          Center(
            child: CircleAvatar(
              radius: 80,
              backgroundColor: pastelFor(recipe.id),
              child: Text(recipe.emoji, style: const TextStyle(fontSize: 90)),
            ),
          ),
          const SizedBox(height: 16),
          Text(recipe.category.toUpperCase(),
              style: const TextStyle(
                  fontSize: 11, letterSpacing: 1.2, color: Colors.teal, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(recipe.name,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kText)),
              ),
              const Icon(Icons.star_rounded, color: kYellow, size: 26),
              Text(' ${recipe.rating}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(recipe.description,
              style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.4)),
          const SizedBox(height: 18),

          // Info singkat
          Row(
            children: [
              _InfoBox(Icons.timer_outlined, '${recipe.duration} mnt', const Color(0xFFBFEFF0)),
              _InfoBox(Icons.people_outline, '${recipe.servings} porsi', kLilac),
              _InfoBox(Icons.emoji_emotions_outlined, recipe.level, kGreen),
            ],
          ),
          const SizedBox(height: 24),

          // Bahan
          const Text('Bahan-bahan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kText)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: recipe.ingredients
                  .map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle, color: Colors.teal, size: 18),
                            const SizedBox(width: 10),
                            Expanded(child: Text(item)),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),

          // Langkah
          const Text('Langkah Memasak',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kText)),
          const SizedBox(height: 10),
          ...List.generate(recipe.steps.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: kYellow,
                    child: Text('${i + 1}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(recipe.steps[i], style: const TextStyle(height: 1.4))),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _InfoBox(this.icon, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}