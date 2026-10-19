import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../pages/recipe_detail_page.dart';
import '../theme.dart';

class RecipeTile extends StatelessWidget {
  final Recipe recipe;
  const RecipeTile({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RecipeDetailPage(recipe: recipe),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: pastelFor(recipe.id),
                  child: Text(recipe.emoji, style: const TextStyle(fontSize: 30)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${recipe.category} • ${recipe.duration} menit',
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: kGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(recipe.level, style: const TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: kYellow, size: 20),
                    Text('${recipe.rating}',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}