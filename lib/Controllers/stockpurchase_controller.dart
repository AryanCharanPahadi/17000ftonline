import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:old17000ft/Controllers/apiCalls.dart';

import '../Model/stockpurchase_model.dart';

class StockPurchaseController extends GetxController {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  List<StockRecieved>? _purchaseList;
 List<StockRecieved> get purchaseList => _purchaseList!;
 

  @override
  void onInit() {
    fetchStockRecieved();
    super.onInit();
  }
 void fetchStockRecieved() async {
    try {
      _isLoading = (true);
      var orders = await ApiCalls.fetchStockRecieved();
      if (orders != null) {
        _purchaseList = [];
        _purchaseList = orders;
        update();
      }
    } finally {
      _isLoading = (false);
    }
    update();
  }

List<String> _getitemid =[];
List<String> get getitemid =>_getitemid;
  void getReceivedItem(String itemid, ) {
    if(_getitemid.contains(itemid)){ 
      getitemid.remove(itemid);
    }else{
      _getitemid.add(itemid);
    }
      update();

  }
  List<String> _getitemqty =[];
List<String> get getitemqty =>_getitemqty;
  void getReceivedQty(String itemqty, ) {
   
      _getitemqty.add(itemqty);
    
      update();

  }

 
  String? _getPurchaseid = null;
  String? get getpurchaseid => _getPurchaseid;
  void getPurchaseid(String purchaseid){
    _getPurchaseid = purchaseid;
    update();

  }
}


                                
                                  
                                 
                                 
                                 
                                  
                                 
                              
                                   
                               
                               
                                 
                                 
                              
                                
                               
                                 
         

        
         