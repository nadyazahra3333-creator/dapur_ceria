import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import '../theme.dart';
import 'home_page.dart';
import 'recipe_list_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;
  String _category = 'Semua';
  late final Future<List<Recipe>> _future = RecipeService.loadRecipes();

  // Dipanggil dari Beranda: pindah ke tab Resep dengan kategori terpilih
  void _openCategory(String category) {
    setState(() {
      _category = category;
      _index = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
        }
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final recipes = snapshot.data!;
        return Scaffold(
          body: IndexedStack(
            index: _index,
            children: [
              HomePage(recipes: recipes, onOpenCategory: _openCategory),
              RecipeListPage(
                recipes: recipes,
                category: _category,
                onCategoryChanged: (c) => setState(() => _category = c),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
            backgroundColor: Colors.white,
            selectedItemColor: kText,
            unselectedItemColor: Colors.black38,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Beranda'),
              BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'Resep'),
            ],
          ),
        );
      },
    );
  }
}