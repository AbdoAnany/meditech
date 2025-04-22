// import 'package:flutter/material.dart';
//
// import 'core/style/app_typography.dart';
// import 'core/widget/widget.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   double _feeValue = 25;
//   double _distanceValue = 15;
//   bool _rememberMe = false;
//   bool _agreeTerms = false;
//   String _numberInput = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 5, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Doctor Appointment System', style: AppTypography.title),
//
//       ),
//       bottomNavigationBar: AppWidgets.tabBar(
//         controller: _tabController,
//         tabs: [
//           Tab(icon: Icon(Icons.home)),
//           Tab(icon: Icon(Icons.medical_services)),
//           Tab(icon: Icon(Icons.calendar_today)),
//           Tab(icon: Icon(Icons.local_hospital)),
//           Tab(icon: Icon(Icons.grid_view)),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(AppLayout.gridMargin),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Input Fields
//             AppWidgets.inputField(
//               hintText: 'Search here...',
//               prefixIcon: Icons.search,
//             ),
//             SizedBox(height: AppLayout.spacingMedium),
//             AppWidgets.inputField(
//               hintText: 'Type your message...',
//               isTextArea: true,
//               suffixIcon: Icons.send,
//             ),
//             SizedBox(height: AppLayout.spacingMedium),
//
//             // Dropdown
//             AppWidgets.dropdown(
//               hintText: '24/7 support HOTLINE',
//               items: ['+089 012-345-789', 'Email support'],
//               onChanged: (value) {},
//             ),
//             SizedBox(height: AppLayout.spacingMedium),
//
//             // Slide Controllers
//             AppWidgets.slideController(
//               min: 25,
//               max: 400,
//               value: _feeValue,
//               onChanged: (value) {
//                 setState(() {
//                   _feeValue = value;
//                 });
//               },
//               label: 'FEE',
//               unit: '\$',
//             ),
//             AppWidgets.slideController(
//               min: 15,
//               max: 30,
//               value: _distanceValue,
//               onChanged: (value) {
//                 setState(() {
//                   _distanceValue = value;
//                 });
//               },
//               label: 'DISTANCE',
//               unit: 'km',
//             ),
//             SizedBox(height: AppLayout.spacingMedium),
//
//             // Checkboxes
//             AppWidgets.checkBox(
//               label: 'REMEMBER ME',
//               value: _rememberMe,
//               onChanged: (value) {
//                 setState(() {
//                   _rememberMe = value ?? false;
//                 });
//               },
//             ),
//             AppWidgets.checkBox(
//               label: 'AGREE WITH TERMS & CONDITION',
//               value: _agreeTerms,
//               onChanged: (value) {
//                 setState(() {
//                   _agreeTerms = value ?? false;
//                 });
//               },
//             ),
//             SizedBox(height: AppLayout.spacingMedium),
//
//             // Compact Card
//             AppWidgets.card(
//               name: 'Dr. John Doe',
//               specialty: 'Cardiologist',
//               experience: '5 Y YEARS',
//               rating: '4.5',
//               onBookNow: () {},
//             ),
//             SizedBox(height: AppLayout.spacingMedium),
//
//             // Detailed Card
//             AppWidgets.detailedCard(
//               name: 'Dr. Jane Smith',
//               specialty: 'Neurologist',
//               experience: '8 Y YEARS',
//               rating: '4.8',
//               date: 'Day, DD MM YY',
//               time: '10:20 - 11:00 AM',
//               onClose: () {},
//             ),
//             SizedBox(height: AppLayout.spacingMedium),
//
//             // Key Number Pad
//             AppWidgets.keyNumberPad(
//               onNumberPressed: (number) {
//                 setState(() {
//                   _numberInput += number;
//                 });
//               },
//               onDeletePressed: () {
//                 setState(() {
//                   if (_numberInput.isNotEmpty) {
//                     _numberInput = _numberInput.substring(0, _numberInput.length - 1);
//                   }
//                 });
//               },
//               onClearPressed: () {
//                 setState(() {
//                   _numberInput = '';
//                 });
//               },
//             ),
//             SizedBox(height: AppLayout.spacingMedium),
//             Text('Input: $_numberInput', style: AppTypography.body1),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
