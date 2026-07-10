import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/database.dart';
import '../models/category_model.dart';

class CategoryService {
  CategoryService();

  final SupabaseClient _supabase = Database.client;

  /// ===========================
  /// Get All Categories
  /// ===========================

  Future<List<CategoryModel>> getCategories() async {
    final response = await _supabase
        .from('categories')
        .select()
        .order('name');

    return response
        .map<CategoryModel>(
          (json) => CategoryModel.fromJson(json),
        )
        .toList();
  }

  /// ===========================
  /// Get Category By ID
  /// ===========================

  Future<CategoryModel> getCategoryById(
    String id,
  ) async {
    final response = await _supabase
        .from('categories')
        .select()
        .eq('id', id)
        .single();

    return CategoryModel.fromJson(response);
  }
}