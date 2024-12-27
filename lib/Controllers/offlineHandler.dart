import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:old17000ft/Model/expense_model.dart';

class OfflineHandler extends GetxController {
  var expenses = <ExpenseModel>[].obs;
  ExpenseModel? _tempExpenses;
  ExpenseModel? get tempExpenses => _tempExpenses;

  var isLoading = false.obs;

  var filterdExpenses = <ExpenseModel>[].obs;

  void getData(String uid) {
    filterdExpenses.value = [];
    filterdExpenses.value = expenses
        .where((p0) => p0.userId == GetStorage().read('userId'))
        .toList();
    update();
  }

  List storageList = [];

  void removedata(int index) {
    expenses.remove(filterdExpenses[index]);
    filterdExpenses.removeAt(index);

    update();
  }

  Future<void> offers(var data) async {
    _tempExpenses = expenseModelFromJson(data);
    expenses.add(_tempExpenses!);
  }

  @override
  void onInit() {
    super.onInit();

    restoreTasks();
    ever(expenses, (_) {
      GetStorage().write('expenses', expenses.toList());
    });
    getData(GetStorage().read('userId'));
  }

  final box = GetStorage();

// looping through you list to see whats inside

  void addAndStoreTask(ExpenseModel task) {
    expenses.add(task);
    final index = expenses.length; // for unique map keys
    final nameKey = 'name$index';
    final descriptionKey = 'description$index';

    final Map storageMap = {}; // temporary map that gets added to storage
    storageMap[nameKey] = task.userId;
    storageMap[descriptionKey] = task.vendorName;

    storageMap['office'] = task.office;
    storageMap['submissionDate'] = task.submissionDate;

    storageMap['tourID'] = task.tourId;
    storageMap['vendorName'] = task.vendorName;
    storageMap['invoiceNumber'] = task.invoiceNumber;
    storageMap['invoiceDate'] = task.invoiceDate;
    storageMap['invoiceAmount'] = task.invoiceAmount;

    storageMap['towardsCost'] = task.towardsCost;
    storageMap['expenseHead'] = task.expenseHead;

    storageMap['projectName'] = task.projectName;
    storageMap['sponsorName'] = task.sponsorName;
    storageMap['expenseBy'] = task.expenseBy;
    storageMap['expenseApprovedBy'] = task.expenseApprovedBy;
    storageMap['invoiceImage'] = task.invoiceImage;
    storageMap['dateOfPayment'] = task.dateOfPayment;

    storageMap['paidBy'] = task.paidBy;
    storageMap['paymentApprovedBy'] = task.paymentApprovedBy;
    storageMap['paidAmount'] = task.paidAmount;
    storageMap['paymentType'] = task.paymentType;

    storageMap['paymentMode'] = task.paymentMode;
    storageMap['userId'] = task.userId;

    storageList.add(storageMap); //

    box.write('expenses', storageList); // adding map of maps to storage
    ever(expenses, (_) {
      GetStorage().write('expenses', expenses.toList());
    });
  }

  void restoreTasks() {
    if (box.read('expenses') != null) {
      storageList = box.read('expenses');
      expenses.value = [];

      for (int i = 0; i < storageList.length; i++) {
        final map = storageList[i];
        // index for retreival keys accounting for index starting at 0
        // ignore: unused_local_variable
        final index = i + 1;

        final task = ExpenseModel(
          office: map['office'],
          submissionDate: map['submissionDate'],
          tourId: map['tourID'],
          vendorName: map['vendorName'],
          invoiceNumber: map['invoiceNumber'],
          invoiceDate: map['invoiceDate'],
          invoiceAmount: map['invoiceAmount'],
          towardsCost: map['towardsCost'],
          expenseHead: map['expenseHead'],
          projectName: map['projectName'],
          sponsorName: map['sponsorName'],
          expenseBy: map['expenseBy'],
          expenseApprovedBy: map['expenseApprovedBy'],
          invoiceImage: map['invoiceImage'],
          dateOfPayment: map['dateOfPayment'],
          paidBy: map['paidBy'],
          paymentApprovedBy: map['paymentApprovedBy'],
          paidAmount: map['paidAmount'],
          paymentType: map['paymentType'],
          paymentMode: map['paymentMode'],
          userId: map['userId'],
        );
        expenses.add(task);

        update();
      }
    }
  }
}
