import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:old17000ft/Controllers/adminLoginController.dart';
import 'package:old17000ft/Controllers/da_controller.dart';
import 'package:old17000ft/Controllers/networ_Controller.dart';
import 'package:old17000ft/Controllers/offlineHandler.dart';
import 'package:old17000ft/Controllers/pendingExpenses_Controller.dart';
import 'package:old17000ft/Controllers/school_Controller.dart';
import 'package:old17000ft/Controllers/stockdispatch_controller.dart';
import 'package:old17000ft/Controllers/stockpurchase_controller.dart';
import 'package:old17000ft/Controllers/tourController.dart';
import 'package:old17000ft/Controllers/userTaskController.dart';
import 'package:old17000ft/collectionForm/schoolEnrollment.dart';
import 'package:old17000ft/forms/cabmeter_tracing.dart';
import 'package:old17000ft/forms/stockSchoolRecieved.dart';
import 'package:old17000ft/pendingScreen.dart';
import 'package:old17000ft/screens/edit_profile.dart';
import 'package:old17000ft/screens/newone_da.dart';
import 'package:old17000ft/screens/profile_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'Controllers/state_Controller.dart';
import 'colors.dart';
import 'da_form.dart';
import 'form.dart';
import 'forms/expense_claim.dart';
import 'forms/leave_request/leave_request.dart';
import 'forms/stockpurchase.dart';
import 'forms/tour_da.dart';
import 'forms/travel_Requisition.dart';
import 'login.dart';

Color shimmer_base = Colors.grey.shade200;

Color shimmer_highlighted = Colors.grey.shade500;

final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
final AdminLoginController _adminLoginController =
    Get.put(AdminLoginController());
final OfflineHandler offlineHandler = Get.put(OfflineHandler());
final StateInfoController stateInfoController = Get.put(StateInfoController());
final AdminLoginController adminLoginController =
    Get.put(AdminLoginController());
final StateController stateController = Get.put(StateController());
final DistrictController districtController = Get.put(DistrictController());
final BlockController blockController = Get.put(BlockController());
final SchoolController schoolController = Get.put(SchoolController());
final StaffController staffController = Get.put(StaffController());
final AuthorityController authController = Get.put(AuthorityController());
final PendingController pendingController = Get.put(PendingController());
final StockPurchaseController stockController =
    Get.put(StockPurchaseController());
final StockDispatchController stockdispatchController =
    Get.put(StockDispatchController());
// final FormController formController= Get.put(FormController());
final TaskController taskController = Get.put(TaskController());
final TourController tourController = Get.put(TourController());
final DaController daController = Get.put(DaController());
final StaffController _staffController = Get.put(StaffController());

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool syncinProgress = false;

class _HomeScreenState extends State<HomeScreen> {
  var userId = GetStorage().read('userId');

  @override
  void initState() {
    super.initState();
    stateController.fetchState();
    authController.fetchAuth();
    schoolController.fetchSchool();
    pendingController.fetchPending();
    stockController.fetchStockRecieved();
    stockdispatchController.fetchStockDispatch();
    staffController.fetchAllStaff();
    adminLoginController
        .fetchAdminLogin(); //staffController.fetchStaff(GetStorage().read('office').toString());
    //formController.fetchForms();
    schoolController.fetchTour();
    taskController.fetchTasks();
    _staffController.getEmployeeData(GetStorage().read('userId'));
  }

  @override
  Widget build(BuildContext context) {
    //String imgurl = _staffController.getProfile();
    _networkManager.GetConnectionType();
    return GetBuilder<GetXNetworkManager>(
        init: GetXNetworkManager(),
        builder: (networkManager) {
          networkManager.GetConnectionType();

          return RefreshIndicator(
            key: const Key('__RIKEY1__'),
            onRefresh: () async {
              await networkManager.GetConnectionType();
            },
            child: Scaffold(
              drawer: Drawer(
                  child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: MyColors.primary,
                    ),
                    accountName: Text(
                        '${GetStorage().read("username")}  (Version: ${GetStorage().read("version")})'),
                    accountEmail: Text(
                        '${GetStorage().read("role")}(${GetStorage().read("office")})'),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      child: Text(
                          GetStorage()
                              .read("username")
                              .toString()
                              .split('')[0]
                              .toUpperCase(),
                          style: const TextStyle(
                              fontSize: 40.0, color: Colors.black)),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: const Text(
                        'My Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        _staffController
                            .getEmployeeData(GetStorage().read('userId'));
                        Get.to(() => const ProfileScreen());
                      },
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      leading: const Icon(Icons.password_outlined),
                      title: const Text(
                        'Change Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Get.to(() => const EditProfile());
                      },
                    ),
                  ),
                  // Card(
                  //   elevation: 5,
                  //   child: ListTile(
                  //     leading: const Icon(Icons.center_focus_strong),
                  //     title: Text(
                  //       GetStorage()
                  //                   .read('officeList')
                  //                   .toString()
                  //                   .replaceAll('[', '')
                  //                   .replaceAll(']', '')
                  //                   .split(',')[0] ==
                  //               'null'
                  //           ? 'Item 2'
                  //           : 'Change Office',
                  //       style: const TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     onTap: () {
                  //       if (GetStorage()
                  //               .read('officeList')
                  //               .toString()
                  //               .replaceAll('[', '')
                  //               .replaceAll(']', '')
                  //               .split(',')[0] !=
                  //           'null') {
                  //         showDailog(context, daController.officeList);
                  //       }
                  //     },
                  //   ),
                  // ),

                  // Card(
                  //   elevation: 5,
                  //   child: ListTile(
                  //     leading: const Icon(Icons.comment_outlined),
                  //     title: const Text(
                  //       'Item 4',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     onTap: () {},
                  //   ),
                  // ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text(
                        'Log out',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        GetStorage().write('isLogged', false);
                        GetStorage().remove('username');
                        GetStorage().remove('role');
                        GetStorage().remove('userId');
                        GetStorage().remove('office');
                        GetStorage().remove('officeList');
                        GetStorage().remove('empda');

                        Get.offAll(() => const Signin2Page());
                      },
                    ),
                  ),
                ],
              )),
              backgroundColor: const Color.fromRGBO(211, 194, 169, 1),
              appBar: AppBar(
                elevation: 0,
                iconTheme: const IconThemeData(color: MyColors.primary),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.logout_sharp),
                    onPressed: () {
                      GetStorage().write('isLogged', false);
                      GetStorage().remove('username');
                      GetStorage().remove('role');
                      GetStorage().remove('userId');
                      GetStorage().remove('office');
                      GetStorage().remove('officeList');
                      GetStorage().remove('empda');

                      Get.offAll(() => const Signin2Page());
                    },
                  ),
                ],
                backgroundColor: const Color.fromRGBO(211, 194, 169, 1),
                title: networkManager.connectionType.value == 0
                    ? const Text('Your are Offline',
                        style: TextStyle(color: MyColors.primary, fontSize: 20))
                    : const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text(
                          '17000 Ft Foundation',
                          style:
                              TextStyle(color: MyColors.primary, fontSize: 20),
                        ),
                      ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/17000ft.jpg',
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Welcome to the 17000 Ft Foundation',
                            style: TextStyle(
                                color: MyColors.primary, fontSize: 18),
                          ),
                          const SizedBox(height: 16),
                          const SizedBox(height: 16),
                          networkManager.connectionType.value == 0
                              ? const Center(
                                  child: Text(
                                  'No Internet(You are Offline)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: MyColors.primary,
                                  ),
                                ))
                              : const GridviewWithBuilderPage()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class GridviewWithBuilderPage extends StatefulWidget {
  const GridviewWithBuilderPage({Key? key}) : super(key: key);

  @override
  _GridviewWithBuilderPageState createState() =>
      _GridviewWithBuilderPageState();
}

class _GridviewWithBuilderPageState extends State<GridviewWithBuilderPage> {
  // initialize global widget
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
        init: TaskController(),
        builder: (taskController) {
          return taskController.isLoading
              ? GridView.builder(
                  itemCount: 6,
                  controller: ScrollController(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 35.0,
                  ),
                  padding: const EdgeInsets.all(8),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: shimmer_base,
                      highlightColor: shimmer_highlighted,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3))
                            ]),
                        height: 50,
                        width: 60,
                      ),
                    );
                  },
                )
              : taskController.taskList!.isEmpty
                  ? const Center(
                      child: Text(
                          'No Task Assigned to you\n Please Contact Admin'))
                  : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: taskController.taskList!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 35.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        var userId = GetStorage().read('userId');
                        var office = GetStorage().read('office');
                        print("User ID of Home Screen: $userId");
                        print("Office of Home Screen: $office");

                        return InkWell(

                          onTap: () {
                            if (taskController.taskList![index].formName! ==
                                'Daily Allowance') {
                              Get.to(() => const NewoneDA());
                             // Get.to(() => const DaForm());
                            } else if (taskController
                                    .taskList![index].formName! ==
                                'Expense Form') {
                              Get.to(() => const Form1());
                            } else if (taskController
                                    .taskList![index].formName! ==
                                'Pending Payments') {
                              Get.to(() => const PendingScreen());
                            } else if (taskController
                                    .taskList![index].formName! ==
                                'Tour Budget') {
                              //   Get.to(() => const TourBudget());
                            } else if (taskController
                                    .taskList![index].formName! ==
                                'Tour DA') {
                              Get.to(() => const TourDa());
                            } else if (taskController
                                    .taskList![index].formName! ==
                                'Stock Recieved') {
                              Get.to(() => const StockPurchase());
                            } else if (taskController
                                    .taskList![index].formName! ==
                                'Stock Distribution') {
                              Get.to(() => const StockSchoolReceived());
                                } else if (taskController
                                        .taskList![index].formName! ==
                                    'Leave Application Form') {
                              Get.to(() => LeaveForm(userId: userId, office: office,));

                              }

                            else if (taskController
                                    .taskList![index].formName! ==
                                'Expense Claim Form') {
                              Get.to(() => const ExpenseClaimForm());
                            } else if (taskController
                                    .taskList![index].formName! ==
                                'Travel Requisition Form') {
                              Get.to(() => const TravelRequisition());
                            } else if (taskController
                                    .taskList![index].formName! ==
                                'School Enrollment Form') {
                              Get.to(() => const SchoolEnrollment());
                            } else if (taskController
                                    .taskList![index].formName! ==
                                'Cab Meter Tracing Form') {
                              Get.to(() => const CabMeterTracing());
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 4,
                                      offset: const Offset(0, 3))
                                ]),
                            child: Center(
                              child: Text(
                                taskController.taskList![index].formName!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: MyColors.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      });
        });
  }
}

// buildShimmer({scontroller, item_count = 6}) {
//   return GridView.builder(
//     itemCount: item_count,
//     controller: scontroller,
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       childAspectRatio: (1 / 1.2),
//       crossAxisCount: 3,
//       mainAxisSpacing: 10,
//       crossAxisSpacing: 10,
//     ),
//     padding: EdgeInsets.all(8),
//     physics: NeverScrollableScrollPhysics(),
//     shrinkWrap: true,
//     itemBuilder: (context, index) {
//       return Shimmer.fromColors(
//         baseColor: shimmer_base,
//         highlightColor: shimmer_highlighted,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(color: Colors.white, spreadRadius: 4, blurRadius: 60)
//             ],
//           ),
//           height: 50,
//           width: 60,
//         ),
//       );
//     },
//   );
// }

buildFieldShimmer(BuildContext context) {
  return Flexible(
    child: Shimmer.fromColors(
      baseColor: shimmer_base,
      highlightColor: shimmer_highlighted,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 4,
                  offset: const Offset(0, 3))
            ]),
        height: 30,
      ),
    ),
  );
}
