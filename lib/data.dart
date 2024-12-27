// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// //import 'forms/issue_tracker.dart';

// class DataModel {
//   List<String> state = [
//     'LADAKH',
//     'SIKKIM',
//   ];

//   List<String> block = [
//     'KARGIL',
//     'LEH(LADAKH)',
//     'MAMRU',
//     'MAMRU',
//     'MAMRU',
//   ];

//   List<String> transport = [
//     'GOODS TRANSPORT',
//     'STAFF TRANSPORT',
//   ];

//   List<String> activity = ['Distribution', 'Setup', 'Data Collection'];
//   List<String> setupProgram = [];

//   List<String> dataCollection = [
//     'Get school data',
//     'Enrollment',
//     'Student Registration',
//   ];

//   List<String> distribution = ['Distribution', 'Setup', 'Data Collection'];

//   List<String> location = ['Leh', 'Kargil', 'Sikkim', 'Gurugram'];

// //   // List<FormModel> form = [
// //   //   FormModel('0', 'Expense Form', () {
// //   //     Get.to(() => const Form1());
// //   //   }),
// //   //   FormModel('1', 'Pending Payments', () {
// //   //     Get.to(() => const PendingScreen());
// //   //   }),

// //   //   // FormModel('2', 'Tour Budget Form', () {
// //   //   //   Get.to(() => const TourBudget());
// //   //   // }),
// //   //   FormModel('3', 'Daily Allowance', () {
// //   //     Get.to(() => const DaForm());
// //   //   }),
// //   //    FormModel('4', 'Issue Tracker', () {
// //   //      Get.to(() => IssueTracker());
// //   //    }),
// //   //    FormModel('5', 'Stock Recieved ', () {
// //   //      Get.to(() =>const StockPurchase());
// //   //    }),
// //   //    FormModel('6', 'Stock Distribution', () {
// //   //      Get.to(() =>const StockDistribution());
// //   //    }),
// //   //   FormModel('7', 'More are coming', () {}),
// //   // ];

//   List<String> sponsor = [
//     'Cipla Foundation',
//     'Manipal Foundation',
//     'HT Parekh Foundation',
//   ];

//   List<String> project = [
//     'Cipla Foundation',
//     'Manipal Foundation',
//     'HT Parekh Foundation',
//   ];

//   List<String> expenseBy = [
//     'Sujata Sahu',
//     'Dolanath Nepal',
//     'Suman Limboo',
//     'Kunzang Choeki',
//   ];

//   List<String> programName = [
//     'DigiLab 2.0',
//     'Playground',
//     'Library',
//     'ICDS Center Upgrade',
//     'Classroom Furniture',
//     'other'
//   ];

//   List<String> expenseHead = [
//     'Communications & Internet',
//     'Electronics & Computers',
//     'Entertainment',
//     'Furniture & Fixtures',
//     'Goods Transport',
//     'Hardware & Tools',
//     'Office Miscellaneous',
//     'Packaging Material',
//     'Pantry',
//     'Repair & Maintenance',
//     'Salary/Stipend',
//     'Sports Equipment',
//     'Staff Welfare',
//     'Stationery and Printing',
//     'Teaching Learning Materials',
//     'Tour: Daily Allowance',
//     'Tour: F&B',
//     'Tour: Miscellaneous',
//     'Tour: Transport',
//     'Utilities',
//     'Vehicle Maintenance'
//   ];
//   List<String> expenseApprovedBy = [
//     'Sandeep Sahu',
//     'Sujata Sahu',
//     'Kunzang Choeki',
//   ];
//   List<String> paymentApprovedBy = [
//     'Sandeep Sahu',
//     'Sujata Sahu',
//     'Kunzang Choeki',
//   ];

//   List<String> paidBy = [
//     'Sandeep Sahu',
//     'Sujata Sahu',
//     'Suman Limboo',
//     'Kunzang Choeki',
//   ];

//   List<String> expenseType = [
//     'Food',
//     'Transport',
//     'Accomodation',
//     'Others',
//   ];

//   List<String> paymentType = [
//     'Pending',
//     'Partial',
//     'Settlement',
//   ];

//   List<String> modeOfGoodsTransport = [
//     'Office Car',
//     'Rented Car',
//     'Mini Truck',
//     'Truck',
//   ];

//   List<String> modeOfStaffTransport = [
//     'Office Car',
//     'Rented Car',
//   ];
//   List<String> officeVehicles = [
//     'Imperio (Jk10A8950)',
//     'Grand i10 (Jk10B1157)',
//     'Xenon (Jk10A2334)',
//   ];

//   List<String> collectionType = [
//     'Get School Data',
//     'Enrollment',
//     'School Mapping',
//     'Village Mapping',
//     'Student Registration',
//     'Teacher Registration',
//   ];

//   List<String> typeOfGoods = [
//     'Books',
//     'Furniture',
//     'Health Kit',
//     'Stationary',
//     'Playground Equipment',
//     'Digilab Equipment',
//     'Library Equipment',
//     'Carpet Furnishing',
//     'Other',
//   ];

//   List<String> Transport = [
//     'Goods Transport',
//     'Staff Transport',
//   ];
//   List<String> paymentMode = [
//     'Cash',
//     'Cheque',
//     'Bank Transfer',
//   ];

//   List<UserModel> user = [
//     UserModel('2', 'userleh', 'userleh@gmail.com', 'userleh', 'leh', 'leh'),
//     UserModel('3', 'userkargil', 'userkargil@gmail.com', 'userkargil', 'kargil',
//         'kargil'),
//     UserModel('4', 'usersikkim', 'usersikkim@gmail.com', 'usersikkim', 'sikkim',
//         'sikkim'),
//   ];

//   List<DistrictModel> districtWithState = [
//     DistrictModel('SIKKIM', 'EAST SIKKIM'),
//     DistrictModel('SIKKIM', 'WEST SIKKIM'),
//     DistrictModel('SIKKIM', 'NORTH SIKKIM'),
//     DistrictModel('SIKKIM', 'SOUTH SIKKIM'),
//     DistrictModel('LADAKH', 'KARGIL'),
//     DistrictModel('LADAKH', 'LEH'),
//   ];

//   List<BlockModel> blockWithDistrict = [
//     BlockModel('EAST SIKKIM', 'DUGA'),
//     BlockModel('EAST SIKKIM', 'GANGTOK'),
//     BlockModel('EAST SIKKIM', 'MARTAM'),
//     BlockModel('EAST SIKKIM', 'RHENOCK'),
//     BlockModel('EAST SIKKIM', 'REGU'),
//     BlockModel('EAST SIKKIM', 'RANKA'),
//     BlockModel('EAST SIKKIM', 'RAKDONG TINTEK'),
//     BlockModel('EAST SIKKIM', 'KHAMDONG'),
//     BlockModel('EAST SIKKIM', 'PAKYONG'),
//     BlockModel('EAST SIKKIM', 'PARAKHA'),
//     BlockModel('WEST SIKKIM', 'CHUMBONG'),
//     BlockModel('WEST SIKKIM', 'DENTAM'),
//     BlockModel('WEST SIKKIM', 'YUKSAM'),
//     BlockModel('WEST SIKKIM', 'KALUK'),
//     BlockModel('WEST SIKKIM', 'CHONGRANG'),
//     BlockModel('WEST SIKKIM', 'DARAMDIN'),
//     BlockModel('WEST SIKKIM', 'SORENG'),
//     BlockModel('WEST SIKKIM', 'GYALSHING'),
//     BlockModel('WEST SIKKIM', 'BERMIOK MARTAM'),
//     BlockModel('NORTH SIKKIM', 'MANGAN'),
//     BlockModel('NORTH SIKKIM', 'PASSINGDONG'),
//     BlockModel('NORTH SIKKIM', 'KABI'),
//     BlockModel('NORTH SIKKIM', 'CHUNGTHANG'),
//     BlockModel('SOUTH SIKKIM', 'RAVANGLA'),
//     BlockModel('SOUTH SIKKIM', 'JORETHANG'),
//     BlockModel('SOUTH SIKKIM', 'NAMCHI'),
//     BlockModel('SOUTH SIKKIM', 'NAMTHANG'),
//     BlockModel('SOUTH SIKKIM', 'SUMBUK'),
//     BlockModel('SOUTH SIKKIM', 'TEMI'),
//     BlockModel('SOUTH SIKKIM', 'YANGANG'),
//     BlockModel('SOUTH SIKKIM', 'SIKKIP'),
//     BlockModel('KARGIL', 'KARGIL'),
//     BlockModel('KARGIL', 'ZANSKAR'),
//     BlockModel('KARGIL', 'DRASS'),
//     BlockModel('KARGIL', 'TAISURU'),
//     BlockModel('KARGIL', 'CHUKTA'),
//     BlockModel('KARGIL', 'SANKOO'),
//     BlockModel('KARGIL', 'SHARGOLE'),
//     BlockModel('LEH', 'DURBUK'),
//     BlockModel('LEH', 'KHALTSE'),
//     BlockModel('LEH', 'KHARU'),
//     BlockModel('LEH', 'LEH'),
//     BlockModel('LEH', 'NUBRA'),
//     BlockModel('LEH', 'NYOMA'),
//   ];
//  }

// class UserModel {
//   String? loginId;
//   String? name;
//   String? email;
//   String? username;
//   String? password;
//   String? office;

//   UserModel(
//     this.loginId,
//     this.name,
//     this.email,
//     this.username,
//     this.password,
//     this.office,
//   );
// }

// class FormModel {
//   String? id;
//   String? formType;
//   Callback? onTap;

//   FormModel(this.id, this.formType, this.onTap);
// }

// class DistrictModel {
//   String? state;
//   String? district;

//   DistrictModel(this.state, this.district);
// }

// class BlockModel {
//   String? district;
//   String? block;

//   BlockModel(this.district, this.block);
// }
