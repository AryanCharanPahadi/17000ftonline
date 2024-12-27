import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:old17000ft/Controllers/apiCalls.dart';
import 'package:old17000ft/Model/blockModel.dart';
import '../db.dart';

class StateInfoController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<StateInfo> _stateInfo = [];
  List<StateInfo> get stateInfo => _stateInfo;

  List<StateInfo> _uniquelist = [];
  List<StateInfo> get uniquelist => _uniquelist;
  String table = 'stateInfoTable';

  filter() {
    var seen = <String>{};

    _uniquelist =
        _stateInfo.where((student) => seen.add(student.stateName!)).toList();

    update();
  }

  final List<StateInfo> _localState = [];
  List<StateInfo> get localState => _localState;

  fetchDb() async {
    var data = await Controller().fetchStateData();
    _localState.addAll(data as Iterable<StateInfo>);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();

    fetchDb();
  }

  void fetchData() async {
    _isLoading = true;

    try {
      var state = await ApiCalls.fetchStateInfo();
      _stateInfo.addAll(state as Iterable<StateInfo>);

      for (var i = 0; i < _stateInfo.length; i++) {
        SqfliteDatabaseHelper().delete(table);
        if (kDebugMode) {
          print("this is from for loop");
        }
        print(_stateInfo[i].blockName);
        Controller().addData(stateInfoModel: _stateInfo[i]);
      }
      _isLoading = false;
      update();
    } finally {
      update();
    }
  }
  
}
