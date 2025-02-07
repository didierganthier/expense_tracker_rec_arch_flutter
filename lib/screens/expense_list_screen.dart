import 'package:expense_tracker_rec_arch_flutter/models/category_model.dart';
import 'package:expense_tracker_rec_arch_flutter/viewmodels/category_viewmodel.dart';
import 'package:expense_tracker_rec_arch_flutter/viewmodels/expense_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseViewModel = Provider.of<ExpenseViewmodel>(context);
    final categoryViewModel = Provider.of<CategoryViewmodel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker")),
      body: ListView.builder(
        itemCount: expenseViewModel.expenses.length,
        itemBuilder: (context, index) {
          final expense = expenseViewModel.expenses[index];
          return ListTile(
            title: Text(expense.title),
            subtitle: Text("\$${expense.amount.toStringAsFixed(2)}"),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => expenseViewModel.deleteExpense(expense.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddExpenseDialog(context, expenseViewModel, categoryViewModel);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddExpenseDialog(BuildContext context,
      ExpenseViewmodel expenseViewModel, CategoryViewmodel categoryViewModel) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    String selectedCategory = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Expense"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<CategoryModel>(
                value: selectedCategory.isEmpty
                    ? null
                    : categoryViewModel.categories.firstWhere(
                        (category) => category.name == selectedCategory),
                items: categoryViewModel.categories.map((category) {
                  return DropdownMenuItem<CategoryModel>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedCategory = value?.name ?? '';
                },
                decoration: InputDecoration(labelText: "Category"),
              ),
              TextButton(
                onPressed: () {
                  // Add new category logic
                  showDialog(
                    context: context,
                    builder: (context) {
                      final newCategoryController = TextEditingController();
                      return AlertDialog(
                        title: Text("Add Category"),
                        content: TextField(
                          controller: newCategoryController,
                          decoration:
                              InputDecoration(labelText: "New Category"),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              categoryViewModel
                                  .addCategory(newCategoryController.text);
                              Navigator.of(context).pop();
                            },
                            child: Text("Add"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("Add New Category"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text;
                final amount = double.tryParse(amountController.text) ?? 0.0;
                if (title.isNotEmpty &&
                    amount > 0 &&
                    selectedCategory != null) {
                  expenseViewModel.addExpense(title, amount, selectedCategory);
                  Navigator.of(context).pop();
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
