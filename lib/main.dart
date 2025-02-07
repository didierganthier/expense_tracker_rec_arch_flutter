import 'package:expense_tracker_rec_arch_flutter/repositories/category_repository.dart';
import 'package:expense_tracker_rec_arch_flutter/viewmodels/category_viewmodel.dart';
import 'package:expense_tracker_rec_arch_flutter/viewmodels/expense_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'repositories/expense_repository.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ExpenseRepository()),
        ChangeNotifierProvider(
          create: (context) => ExpenseViewmodel(
            context.read<ExpenseRepository>(),
          ),
        ),
        Provider(create: (_) => CategoryRepository()),
        ChangeNotifierProvider(
          create: (context) => CategoryViewmodel(
            context.read<CategoryRepository>(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
