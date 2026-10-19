import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/recipe.dart';

// Sumber data resep. Sekarang dari JSON lokal,
// nanti cukup diganti ke permintaan API tanpa mengubah halaman.
class RecipeService {
  static Future<List<Recipe>> loadRecipes() async {
    final raw = await rootBundle.loadString('assets/data/recipes.json');
    final List data = json.decode(raw);
    return data.map((e) => Recipe.fromJson(e)).toList();
  }
}