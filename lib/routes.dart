import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/expense_list_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ExpenseListScreen(),
    ),
  ],
);
