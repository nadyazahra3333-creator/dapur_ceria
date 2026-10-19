import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme.dart';
import '../widgets/recipe_tile.dart';

class RecipeListPage extends StatefulWidget {
  final List<Recipe> recipes;
  final String category;
  final void Function(String) onCategoryChanged;

  const RecipeListPage({
    super.key,
    required this.recipes,
    required this.category,
    required this.onCategoryChanged,
  });

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  String _query = '';
  static const _categories = ['Semua', 'Sarapan', 'Makan Siang', 'Dessert'];

  @override
  Widget build(BuildContext context) {
    // Filter berdasarkan kategori dan kata kunci pencarian
    final shown = widget.recipes.where((r) {
      final matchCategory =
          widget.category == 'Semua' || r.category == widget.category;
      final matchQuery = r.name.toLowerCase().contains(_query.toLowerCase());
      return matchCategory && matchQuery;
    }).toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Daftar Resep',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: kText)),
          const SizedBox(height: 14),

          // Kolom pencarian
          TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Cari resep...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Chip kategori
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories
                  .map((c) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(c),
                          selected: widget.category == c,
                          selectedColor: kYellow,
                          backgroundColor: Colors.white,
                          side: BorderSide.none,
                          onSelected: (_) => widget.onCategoryChanged(c),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Hasil
          if (shown.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(child: Text('Resep tidak ditemukan 🥲')),
            )
          else
            ...shown.map((r) => RecipeTile(recipe: r)),
        ],
      ),
    );
  }
}