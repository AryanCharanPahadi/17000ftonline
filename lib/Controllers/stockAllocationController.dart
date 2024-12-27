import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:old17000ft/Controllers/apiCalls.dart';
import '../Model/allocateModel.dart';
import '../Model/distribution.dart';

class StockAllocationController extends GetxController {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<AllocateModel> _allocateList = [];
  List<AllocateModel> get allocateList => _allocateList;
  List<AllocateModel> _uniqueAllocateList = [];
  List<AllocateModel> get uniqueAllocateList => _uniqueAllocateList;
  List<AllocateModel> _allocateSchool = [];
  List<AllocateModel> get allocateSchool => _allocateSchool;
  List<AllocateModel> _allocateSchool1 = [];
  List<AllocateModel> get allocateSchool1 => _allocateSchool1;

  List<AllocateModel> _finalallocateSchool1 = [];
  List<AllocateModel> get finalallocateSchool1 => _allocateSchool1;

  List<AllocateModel> _schoolItemAllocateList = [];
  List<AllocateModel> get schoolItemAllocateList => _schoolItemAllocateList;

  List<AllocateModel> _getItemId = [];

  List<String> _itemsName = [];
  List<String> _filteritemsName = [];
  List<String> get filteritemsName => _filteritemsName;

  List<String> get itemsName => _itemsName;
  String? _itemsId;
  String? get itemsId => _itemsId;
  String? _receiverCommonId;
  String? get receiverCommonId => _receiverCommonId;
  String? _allocateQty;
  String? get allocateQty => _allocateQty;
  final List<StockDistributionModel> _stockDistributionItem = [];
  List<StockDistributionModel> get stockDistributionItem =>
      _stockDistributionItem;

  //filter allocatuib list on the basis of officedid
  void filterList() async {
    _uniqueAllocateList = [];
    _uniqueAllocateList = allocateList
        .where((element) => element.officeId == GetStorage().read('officeId'))
        .toList();
  }

  void getItemsName(school) {
    var seen = <String>{};
    print('getitem name is calleld');
    _itemsName = [];
    _schoolItemAllocateList = _uniqueAllocateList
        .where((element) => element.schoolName == school)
        .toList();
        print('name');
    print(_schoolItemAllocateList.length);
    for (int i = 0; i < _schoolItemAllocateList.length; i++) {
      _itemsName.add(_schoolItemAllocateList[i].itemName!);
      print(_itemsName.length);
      _filteritemsName = _itemsName.toSet().toList();
    }
    print(_filteritemsName.length);
  }

  //add items into list

//filter school name
  void filterSchoolName(List<String> block) {
    var seen = <String>{};
    _allocateSchool = [];
    _allocateSchool1 = [];
    _finalallocateSchool1 = [];

    print('filterschool is called from allocatelist');
    for (int i = 0; i < block.length; i++) {
      var blockValue = block[i].replaceAll(',', '');
      print(blockValue);
      _allocateSchool = _uniqueAllocateList
          .where((element) => element.schoolBlock == blockValue)
          .toList();
      _allocateSchool1 = _allocateSchool1 +
          _allocateSchool
              .where((student) => seen.add(student.schoolName!))
              .toList();
      _finalallocateSchool1 = _allocateSchool1
          .where((student) => seen.add(student.schoolName!))
          .toList();
      print('length of allocate school list');
      print(_allocateSchool1.length);
    }
  }

  getUniqueId(String? data) {
    print('getuniqueid is called');
    _getItemId = _uniqueAllocateList
        .where((element) => element.itemName == data)
        .toList();
    _itemsId = _getItemId[0].itemUniqueId;
    _receiverCommonId = _getItemId[0].recievedCommonId;
    _allocateQty = _getItemId[0].allocateQty;
  }

//add Stock Distribution list
  addStockDistribution(StockDistributionModel distributedItem) {
    print('add stock item is called');
    _stockDistributionItem.add(distributedItem);
    update();
    print(_stockDistributionItem.length);
  }

  //remove stock distribution item
  removeStockDistribution(StockDistributionModel itemObj) {
    print('remove stock item is called');
    _stockDistributionItem.remove(itemObj);
  }

  @override
  void onInit() {
     super.onInit();
    fetchStockAllocation();
   
  }

  Future fetchStockAllocation() async {
    try {
      _isLoading = (true);
      _allocateList = [];
      print('stock allocation is caleled by init');
      var orders = await ApiCalls.fetchStockAllocation();
      if (orders.isNotEmpty) {
        
      
        _allocateList = orders;
         update();
      }
      print("allocation length");
     // print(_allocateList[0].schoolName);
      print(_allocateList.length);
     
    } catch (e) {
      Exception();
      if (kDebugMode) {
        print('Exception occured in stock Allocation');
      }
    } finally {
      _isLoading = (false);
    }
    update();
  }
}
