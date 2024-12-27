import 'package:get/get.dart';
import 'package:old17000ft/Model/expenseclaim_model.dart';

class ExpenseClaimContoller extends GetxController {
  final bool _isLoading = false;
  bool get isLoading => _isLoading;

   List<ExpenseClaim>? _finalExpenseClaimList = [];
  List<ExpenseClaim> get finalExpenseClaimList => _finalExpenseClaimList!;

  addExpense(ExpenseClaim data) {
    _finalExpenseClaimList!.add(data);
    update();
  }

  removeClaim(index) {
    _finalExpenseClaimList!.removeAt(index);
    update();
  }
}
