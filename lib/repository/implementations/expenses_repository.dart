import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividido/const/external_response.dart';
import 'package:dividido/models/expense.dart';
import 'package:dividido/repository/contracts/expenses_repository.ct.dart';

class ExpensesRepository implements ExpensesRepositoryCT {
  @override
  final String groupId;
  final firestore = FirebaseFirestore.instance;
  ExpensesRepository(this.groupId);

  @override
  Future<ExternalResponse> addExpense(Expense expense) async {
    try {
      await firestore.collection('groups').doc(groupId).collection('expenses').add(expense.toMap());
      return ExternalResponse.success;
    } catch (e) {
      log("[ExpensesRepository] [addExpense] - Error adding expense: $e");
      return ExternalResponse.error;
    }
  }

  @override
  Future<List<Expense>?> getExpenses() async {
    try {
      final expenses = await firestore.collection('groups').doc(groupId).collection('expenses').get();
      return expenses.docs.map((e) => Expense.fromMap(e.id, e.data())).toList();
    } catch (e) {
      log("[ExpensesRepository] [getExpenses] - Error getting expenses: $e");
      return null;
    }
  }

  @override
  Future<List<Expense>?> getLast5Expenses() async {
    try {
      final expenses =
          await firestore.collection('groups').doc(groupId).collection('expenses').limit(5).get();
      return expenses.docs.map((e) => Expense.fromMap(e.id, e.data())).toList();
    } catch (e) {
      log("[ExpensesRepository] [getLast5Expenses] - Error getting last 5 expenses: $e");
      return null;
    }
  }

  @override
  Future<ExternalResponse> removeExpense(String expenseId) async {
    try {
      await firestore.collection('groups').doc(groupId).collection('expenses').doc(expenseId).delete();
      return ExternalResponse.success;
    } catch (e) {
      log("[ExpensesRepository] [removeExpense] - Error removing expense: $e");
      return ExternalResponse.error;
    }
  }
}
