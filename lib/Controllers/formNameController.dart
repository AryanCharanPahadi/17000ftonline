// // ignore_for_file: unused_field, avoid_print

// import 'package:form/Controllers/apiCalls.dart';
// import 'package:form/Controllers/userTaskController.dart';
// import 'package:form/Model/formModel.dart';
// import 'package:get/get.dart';

// final TaskController taskController = Get.put(TaskController());
// class FormController extends GetxController{
//   bool _isLoading = (false);
//   bool get isLoading => _isLoading;
//   List<Forms>? _formList;
//   List<Forms>? get formList => _formList;
//   List<String>? _getTaskList ;
//   List<Forms>? _getTaskName;
//   List<Forms>? _allTaskName;
//   String?  _formname;
//   List<String>? _finalformname;
//   List<String>? get finalformname => _finalformname;
  

// @override
//   void onInit(){
//  fetchForms();
//  super.onInit();

// }
// void fetchForms() async {
//     try {
//       _isLoading = (true); 
//       var orders = await ApiCalls.fetchForms();
//       if (orders != null) {
       
//         _formList = orders;
//         print("data is uploaded");
//         print(_formList!.length);
      
//         update();
//       }
//     } finally {
//       _isLoading = (false);
//     }
//     update();
//   }
//  getMyTask(String? tasks){
//   print("gettask is called");
//   _getTaskList = tasks!.split(',');
//   print('array tasks');
//   print(_getTaskList);
// _finalformname = [];
//   for(int i=0;i<_getTaskList!.length;i++){
//     _getTaskName = _formList!.where((element) => element.formId == _getTaskList![i]).toList();
//     print(_getTaskName![0].formName);
//     _formname = _getTaskName![0].formName ;
    
//     _finalformname = _finalformname!..add(_formname!);
//    }
//   //  print("length od forma taks");
//   //  print(_finalformname!.length);

// }
 



// }