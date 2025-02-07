import 'package:expense_tracker_rec_arch_flutter/models/expense_model.dart';
import 'package:expense_tracker_rec_arch_flutter/repositories/expense_repository.dart';
import 'package:flutter/material.dart';

class ExpenseViewmodel extends ChangeNotifier {
  final ExpenseRepository _expenseRepository;

  List<ExpenseModel> _expenses = [];

  List<ExpenseModel> get expenses => _expenses;

  ExpenseViewmodel(this._expenseRepository) {
    fetchExpenses();
  }

  Future<void> fetchExpenses() async {
    _expenses = await _expenseRepository.getExpenses();
    notifyListeners();
  }

  Future<void> addExpense(String title, double amount, category) async {
    final newExpense = ExpenseModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      amount: amount,
      date: DateTime.now(),
      category: category,
    );
    await _expenseRepository.insertExpense(newExpense);
    fetchExpenses();
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    await _expenseRepository.updateExpense(expense);
    fetchExpenses();
  }

  Future<void> deleteExpense(int id) async {
    await _expenseRepository.deleteExpense(id);
    fetchExpenses();
  }

  double getTotalExpensesForMonth(int month, int year) {
    return expenses
        .where((e) => e.date.month == month && e.date.year == year)
        .fold(0, (prev, e) => prev + e.amount);
  }
}
