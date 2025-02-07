import 'package:expense_tracker_rec_arch_flutter/models/category_model.dart';
import 'package:expense_tracker_rec_arch_flutter/repositories/category_repository.dart';
import 'package:flutter/material.dart';

class CategoryViewmodel extends ChangeNotifier {
  final CategoryRepository _categoryRepository;

  CategoryViewmodel(this._categoryRepository) {
    fetchCategories();
  }

  final List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  Future<void> fetchCategories() async {
    await _categoryRepository.getCategories();
    notifyListeners();
  }

  Future<void> addCategory(String title) async {
    final newCategory = CategoryModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), name: title);
    await _categoryRepository.insertCategory(newCategory);
    fetchCategories();
  }

  Future<void> updateCategory(CategoryModel category) async {
    await _categoryRepository.updateCategory(category);
    fetchCategories();
  }

  Future<void> deleteCategory(String id) async {
    await _categoryRepository.deleteCategory(id);
    fetchCategories();
  }
}
