
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:old17000ft/Controllers/apiCalls.dart';
import 'package:old17000ft/Model/pending_expenses.dart';
import 'package:old17000ft/Model/state_model.dart';

class PendingController extends GetxController {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  // ignore: deprecated_member_use
  // var ordersList = List<Orders>().obs;
  List<PendingExpense>? _pendingList;

  List<PendingExpense> get pendingList => _pendingList!;

  @override
  void onInit() {
    fetchPending();
    super.onInit();
  }

//filter orders on basis of user id

  // fetchOrders1() async {
  //   isLoading.value = true;
  //   var response = await RemoteServices.fetchOrders();
  //   if (response != null) {
  //     ordersList.value = response;
  //     this.ordersList.refresh();
  //     update();
  //   }
  //   isLoading.value = false;
  // }

  void fetchPending() async {
    try {
      _isLoading = (true);
      var orders = await ApiCalls.fetchPendingForms();
      _pendingList = [];
      _pendingList!.addAll(orders);
      _isLoading = false;

      update();
        } finally {
      _isLoading = false;
    }
    update();
  }
}

class StateController extends GetxController {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  // ignore: deprecated_member_use
  // var ordersList = List<Orders>().obs;
  StateModel? _stateList;

  StateModel get stateList => _stateList!;

  @override
  void onInit() {
    fetchState();
    super.onInit();
  }

//filter orders on basis of user id

  // fetchOrders1() async {
  //   isLoading.value = true;
  //   var response = await RemoteServices.fetchOrders();
  //   if (response != null) {
  //     ordersList.value = response;
  //     this.ordersList.refresh();
  //     update();
  //   }
  //   isLoading.value = false;
  // }

  void fetchState() async {
    try {
      _isLoading = (true);
      var orders = await ApiCalls.fetchState();

      _stateList = null;
      _stateList = orders;

      update();
    } finally {
      _isLoading = (false);
      update();
    }
    update();
  }
}

class DistrictController extends GetxController {
  final bool _isLoading = true;
  bool get isLoading => _isLoading;
  // ignore: deprecated_member_use

  // DistrictModel? _districtList;
  // ignore: deprecated_member_use
  var districtList = DistrictModel().obs;

  // DistrictModel get districtList => _districtList!;

  @override
  void onInit() {
    // fetchDistrict();

    DistrictModel? district = GetStorage().read('district');

    // ignore: deprecated_member_use
    if (district != null) {
      districtList.value = district;
    }
    ever(districtList, (_) {
      GetStorage().write('cartItems', districtList);
    });

    super.onInit();
  }

//filter orders on basis of user id

  // fetchOrders1() async {
  //   isLoading.value = true;
  //   var response = await RemoteServices.fetchOrders();
  //   if (response != null) {
  //     ordersList.value = response;
  //     this.ordersList.refresh();
  //     update();
  //   }
  //   isLoading.value = false;
  // }

  // void fetchDistrict() async {
  //   try {
  //     _isLoading = (true);
  //     var orders = await ApiCalls.fetchData('SIKKIM', 'STATE', 'DISTNAME');

  //     districtList.value = orders;

  //     update();
  //   } finally {
  //     _isLoading = (false);
  //     update();
  //   }
  //   update();
  // }
}

class BlockController extends GetxController {
  var isLoading = true.obs;

  BlockModel? _blockList;

  BlockModel get blockList => _blockList!;

  @override
  void onInit() {
    fetchState();
    super.onInit();
  }

  void fetchState() async {
    try {
      isLoading.value = (true);
      var orders =
          await ApiCalls.fetchBlock('EAST SIKKIM', 'DISTNAME', 'BLOCK_NAME');

      _blockList = null;
      _blockList = orders;
      isLoading.value = (false);

      update();
    } finally {
      isLoading.value = (false);
      update();
    }
    update();
  }
}
