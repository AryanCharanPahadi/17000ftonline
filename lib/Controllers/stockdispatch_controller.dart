import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:old17000ft/Controllers/apiCalls.dart';

import '../Model/newStock_dispatch.dart';

class StockDispatchController extends GetxController {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<StockDispatch>? _dispatchList = [];
  List<StockDispatch> get dispatchList => _dispatchList ?? [];

  final List<StockDispatch> _newDispatchList = [];
  List<StockDispatch> get newDispatchList => _newDispatchList ?? [];

  List<StockDispatch>? _uniqueDispatchList = [];
  List<StockDispatch>? get uniqueDispatchList => _uniqueDispatchList;

  List<StockDispatch>? _uniqueDispatchCommonId = [];
  List<StockDispatch>? get uniqueDispatchCommonId => _uniqueDispatchCommonId;

  List<StockDispatch>? _dispatchItemList = [];
  List<StockDispatch>? get dispatchItemList => _dispatchItemList;

  final List<StockDispatch> _addStockItem = [];
  List<StockDispatch> get addStockItem => _addStockItem;

  final List<TextEditingController> _qtyControllers = [];
  List<TextEditingController> get qtyControllers => _qtyControllers;

  final List<String> _dispatchId = [];
  List<String> get dispatchId => _dispatchId;

  final List<String> _getitemid = [];
  List<String> get getitemid => _getitemid;

  final List<String> _getitemqty = [];
  List<String> get getitemqty => _getitemqty;

  final List<String> _getdispatchid = [];
  List<String> get getdispatchid => _getdispatchid;

  final List<String> _geteditqty = [];
  List<String> get geteditqty => _geteditqty;

  String? _itemsqty;
  String? get itemsqty => _itemsqty;

  String? _itemsname;
  String? get itemsname => _itemsname;

  String? _itemnameValue;
  String? get itemnameValue => _itemnameValue;

  String? _getPurchaseid;
  String? get getpurchaseid => _getPurchaseid;

  @override
  void onInit() {
    fetchStockDispatch();
    super.onInit();
  }

  Future fetchStockDispatch() async {
    try {
      print('fetchStock is called');
     
        _dispatchList = [];

     
      var orders = await ApiCalls.fetchStockDispatch();

      if (orders.isNotEmpty) {
        _dispatchList = orders;
         update(); // Trigger UI update to show loading state
        print("Dispatch length: ${_dispatchList!.length}");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception occurred in stock dispatch: $e');
      }
    } finally {
      _isLoading = false;
      update(); // Trigger UI update to show data once loaded
    }
  }

   filterList() {
    try {
       _isLoading = true;
       //fetchStockDispatch();

      String? officeId = GetStorage().read('officeId');
      print('Office ID: $officeId');
     // fetchStockDispatch();
      _uniqueDispatchList = _dispatchList!
          .where((element) => element.toOfficeId == officeId)
          .toList();

      // Use a set to track unique `dispatchCommonId`
      var seen = <String>{};
      _uniqueDispatchCommonId = _uniqueDispatchList!
          .where((element) => seen.add(element.dispatchCommonId!))
          .toList();

      print('Filtered unique dispatch length: ${_uniqueDispatchList!.length}');
      print('Unique common IDs length: ${_uniqueDispatchCommonId!.length}');
      _isLoading = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print('Exception occurred in filterList: $e');
      }
    }
  }

  void getItem(String dispatchCommonId) {
    _dispatchItemList = _uniqueDispatchList!
        .where((element) => element.dispatchCommonId == dispatchCommonId)
        .toList();

    print('Get item called for dispatchCommonId: $dispatchCommonId');
    print('Items found: ${_dispatchItemList!.length}');
    update();
  }

  // Manage TextEditingControllers
  void addController() {
    _qtyControllers.add(TextEditingController());
    print("Controller added. Total controllers: ${_qtyControllers.length}");
  }

  void setControllerQty(int index) {
    if (index < _dispatchItemList!.length) {
      _qtyControllers[index].text = _dispatchItemList![index].itemQty ?? '';
      print('Controller qty set for index $index with qty: ${_qtyControllers[index].text}');
    } else {
      print('Invalid index for setControllerQty');
    }
  }

  void setQty(String qtyValue, int index) {
    if (index < _qtyControllers.length) {
      _qtyControllers[index].text = qtyValue;
      print('Qty set for controller $index with value $qtyValue');
    } else {
      print('Invalid index for setQty');
    }
  }

  void getQty(String qty, String itemId) {
    for (var item in _addStockItem) {
      if (item.itemUniqueId == itemId) {
        item.itemQty = qty;
        print('Updated qty for $itemId: $qty');
      }
    }
    update();
  }

  // Received Item Management
  void getReceivedItem(String itemId) {
    if (_getitemid.contains(itemId)) {
      _getitemid.remove(itemId);
      print('Item removed: $itemId');
    } else {
      _getitemid.add(itemId);
      print('Item added: $itemId');
    }
    update();
  }

  void getReceivedQty(String itemQty) {
    _getitemqty.add(itemQty);
    print('Qty added: $itemQty');
    update();
  }

  void getDispatchId(String dispatchId) {
    _getdispatchid.add(dispatchId);
    print('Dispatch ID added: $dispatchId');
    update();
  }

  void getEditQty(String qty) {
    if (_geteditqty.contains(qty)) {
      _geteditqty.remove(qty);
      print('Qty removed from edit: $qty');
    } else {
      _geteditqty.add(qty);
      print('Qty added for edit: $qty');
    }
    update();
  }

  // Value setters
  void qtySetter(String value) {
    _itemsqty = value;
    print('Items qty set to: $_itemsqty');
    update();
  }

  void itemSetter(String value) {
    _itemsname = value;
    print('Items name set to: $_itemsname');
    update();
  }

  void setValue(String data) {
    _itemnameValue = data.isEmpty ? null : data;
    print('Item value set: $_itemnameValue');
    update();
  }

  void getPurchaseid(String purchaseId) {
    _getPurchaseid = purchaseId;
    print('Purchase ID set: $_getPurchaseid');
    update();
  }

  // Clearing list values
  void setListValue() {
    _getitemid.clear();
    _getitemqty.clear();
    _getdispatchid.clear();
    print('Lists cleared');
    update();
  }
}
