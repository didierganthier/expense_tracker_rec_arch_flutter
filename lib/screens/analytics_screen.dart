import 'package:expense_tracker_rec_arch_flutter/viewmodels/category_viewmodel.dart';
import 'package:expense_tracker_rec_arch_flutter/viewmodels/expense_viewmodel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseViewModel = Provider.of<ExpenseViewmodel>(context);
    final categoryViewModel = Provider.of<CategoryViewmodel>(context);

    // get total expenses for each category
    final categoryTotals = {
      for (var category in categoryViewModel.categories)
        category.name: expenseViewModel.expenses
            .where((e) => e.category.name == category.name)
            .fold(0.0, (prev, e) => prev + e.amount)
    };

    return Scaffold(
      appBar: AppBar(title: Text("Expense Analytics")),
      body: Center(
        child: PieChart(
          PieChartData(
            sections: categoryTotals.entries.map((entry) {
              return PieChartSectionData(
                value: entry.value,
                title: entry.key,
                color: Colors
                    .primaries[categoryTotals.keys.toList().indexOf(entry.key)],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
