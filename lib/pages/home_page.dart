import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme.dart';
import '../widgets/recipe_tile.dart';
import 'recipe_detail_page.dart';

class HomePage extends StatelessWidget {
  final List<Recipe> recipes;
  final void Function(String category) onOpenCategory;

  const HomePage({
    super.key,
    required this.recipes,
    required this.onOpenCategory,
  });

  @override
  Widget build(BuildContext context) {
    // Resep populer = rating tertinggi
    final popular = [...recipes]..sort((a, b) => b.rating.compareTo(a.rating));

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Sapaan
          const Text('Happy Cooking 👩‍🍳',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: kText)),
          const SizedBox(height: 4),
          const Text('Mau masak apa hari ini?',
              style: TextStyle(fontSize: 14, color: Colors.black54)),
          const SizedBox(height: 16),

          // Kolom pencarian (menuju halaman daftar resep)
          TextField(
            readOnly: true,
            onTap: () => onOpenCategory('Semua'),
            decoration: InputDecoration(
              hintText: 'Cari resep favoritmu',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 22),

          // Kategori
          const Text('Kategori',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kText)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CategoryCard('Sarapan', '🥞', kLilac, onOpenCategory),
              _CategoryCard('Makan Siang', '🍛', kGreen, onOpenCategory),
              _CategoryCard('Dessert', '🍰', kCream, onOpenCategory),
            ],
          ),
          const SizedBox(height: 22),

          // Resep populer (geser ke samping)
          const Text('Resep Populer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kText)),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: popular.length > 4 ? 4 : popular.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) => _PopularCard(recipe: popular[i]),
            ),
          ),
          const SizedBox(height: 22),

          // Resep terbaru
          const Text('Resep Terbaru',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kText)),
          const SizedBox(height: 12),
          ...recipes.reversed.take(3).map((r) => RecipeTile(recipe: r)),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String name;
  final String emoji;
  final Color color;
  final void Function(String) onTap;

  const _CategoryCard(this.name, this.emoji, this.color, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => onTap(name),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 32)),
                  const SizedBox(height: 6),
                  Text(name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PopularCard extends StatelessWidget {
  final Recipe recipe;
  const _PopularCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RecipeDetailPage(recipe: recipe)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: pastelFor(recipe.id),
                  child: Text(recipe.emoji, style: const TextStyle(fontSize: 40)),
                ),
                const SizedBox(height: 10),
                Text(recipe.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: kText)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star_rounded, color: kYellow, size: 18),
                    Text(' ${recipe.rating}  •  ${recipe.duration} mnt',
                        style: const TextStyle(fontSize: 12)),
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