import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:old17000ft/Controllers/apiCalls.dart';
import 'package:old17000ft/Model/usertaskModel.dart';

class TaskController extends GetxController {
  bool _isLoading = (false);
  bool get isLoading => _isLoading;
  List<TaskId>? _taskList;
  List<TaskId>? get taskList => _taskList;
  // List<TaskId>? _filterTaskList;
  // List<TaskId>? get filterTaskList => _filterTaskList;
  String? _mytasks;
  String? get mytasks => _mytasks;
  String id = GetStorage().read('userId').toString();
  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  void fetchTasks() async {
    _isLoading = (true);

    _taskList = [];

    try {
      _isLoading = (true);
      var orders = await ApiCalls.fetchTasks(id);
      if (orders != null) {
        _taskList = orders;
        // _filterTaskList =
        //     _taskList!.where((element) => element.empId == id).toList();
        // _mytasks = _filterTaskList![0].taskId;
        // print("mine" + _mytasks!);
        // //  formController.getMyTask(_mytasks);
        //   if(_taskList!.isNotEmpty){
        //      print("thsi is lenfth of tasklist");
        //      print(_taskList!.length);
        //  var tasks =    taskController.getFiltered();
        //  print("my tasks"+tasks);
        //   }else{
        //     print("tasklist has not data yet");
        //   }
        _isLoading = (false);

        update();
      }
    } finally {
      _isLoading = (false);
      update();
    }
  }

//  getFiltered(){
//    print("Function getfiltered is called at this tume tasklist length is");
//    print(taskList!.length);
//    _filterTaskList = [];
//    if(_taskList!.isEmpty){
//     Future.delayed(const Duration(milliseconds:200), () {
//   _filterTaskList = taskList!.where((element) => element.empId == GetStorage().read('userId')).toList();
//   print("len of filtered task");
//   print(_filterTaskList!.length);
//   //mytasks =  _filterTaskList![0].empTaskId;
//   update();
//   print("This is my tasks"+mytasks!);
//   return mytasks;

// });
//    }else{
//      _filterTaskList = taskList!.where((element) => element.empId == GetStorage().read('userId')).toList();
//   mytasks =  _filterTaskList![0].empTaskId;
//    print("len of filtered task");
//   print(_filterTaskList!.length);
//   print(_filterTaskList);
//   update();
//   print("This is my tasks"+mytasks!);
//   return mytasks;

//    }

//}

}
