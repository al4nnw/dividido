import 'package:dividido/const/external_response.dart';
import 'package:dividido/models/expense.dart';

abstract class ExpensesRepositoryCT {
  final String groupId;

  ExpensesRepositoryCT(this.groupId);

  Future<ExternalResponse> addExpense(Expense expense);

  Future<ExternalResponse> removeExpense(String expenseId);

  Future<List<Expense>?> getExpenses();

  Future<List<Expense>?> getLast5Expenses();
}
