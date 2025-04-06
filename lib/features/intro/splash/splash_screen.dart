// import 'package:meditech/core/style/app_color.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../core/constants/image_strings.dart';
// import '../onbording/onboarding_screen.dart';
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               AppColor.primaryDarkColor,
//               AppColor.primaryDarkColor,
//             ],
//           ),
//         ),
//         child: Column(
//              children: [
//
//
//
//           Container(
//             height: 500,
//             width: double.infinity,
//             padding: EdgeInsets.only(top: 60),
//             decoration: BoxDecoration(
//               color: AppColor.white,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(40),
//                 bottomRight: Radius.circular(40),
//               ),
//             ),
//             child: Image.asset(
//               ImageApp.doctor,
//
//               fit: BoxFit.contain,
//
//               // width: double.infinity,
//             ),
//           ),
//
//           CupertinoButton(
//               color: AppColor.white,
//               borderRadius: BorderRadius.circular(16),
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//
//
//               child: SizedBox(
//                   // width: 140,
//                   child: Text('ابدأ الان',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 25,
//                           color: AppColor.primaryColor))),
//               onPressed: (){
//
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
//               })
//         ]),
//       ),
//     );
//   }
// }
//
// class SplashScreen1 extends StatelessWidget {
//   const SplashScreen1({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               AppColor.secondaryColor,
//               AppColor.primaryColor,
//             ],
//           ),
//         ),
//         child: Stack(
//             clipBehavior: Clip.none,
//             alignment: Alignment.center, children: [
//           Positioned(
//             top: 0,
//             left: -80,
//             child: Image.asset(
//               ImageApp.gastric,
//               width: 500,
//               color: Colors.white12,
//             ),
//           ),
//
//           Positioned(
//              top: 70,
//                right: 20   ,
//             // left: 0,
//             child: Text.rich(
//
//               TextSpan(
//
//                 children: [
//                   TextSpan(
//                     text: 'هدفنا\n',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 50,
//                       height: 1, // Adds space between lines <button class="citation-flag" data-index="3">
//                     ),
//                   ),
//                   TextSpan(
//                     text: 'توفير حياة صحية لمرضى السمنة\n',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       height: 1.5, // Adds more space between lines
//                     ),
//                   ),
//                   TextSpan(
//                     text: 'بأفضل وأنسب الطرق الحديثة\n',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       height: 1.5,
//                     ),
//                   ),
//                   TextSpan(
//                     text: 'نخطط أن نكون المركز    \n  ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       height: 1.5,
//                     ),
//                   ),
//                   TextSpan(
//                     text: 'رقم واحد\n',
//
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 40,
//                       fontWeight: FontWeight.bold,
//
//                       height: 1.5,
//                     ),
//                   ),        TextSpan(
//                     text: 'في مصر والشرق الأوسط\n',
//
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//
//                       height: 1,
//                     ),
//                   ),
//                 ],
//               ),
//               textAlign: TextAlign.end, // Ensures right-to-left alignment for Arabic text <button class="citation-flag" data-index="2">
//             ),
//
//               // Text('هدفنا توفير حياة صحية لمرضى السمنة\n بأفضل وأنسب الطرق الحديثة\n ونخطط أن نكون المركز\n رقم واحد في مصر \nوالشرق الأوسط',style: TextStyle(
//               //
//               //     fontWeight: FontWeight.bold,
//               //
//               //     color: Colors.white,fontSize: 22),
//               // textAlign: TextAlign.end,
//               // )
//       ),
//           Positioned(
//             bottom: 0,right: -40,
//             child: Image.asset(
//               ImageApp.doctor,
//               width: 370,
//               fit: BoxFit.contain,
//
//               // width: double.infinity,
//             ),
//           ),
//
//           Positioned(
//             bottom: 30,
//             // left: 20,
//             child: CupertinoButton(
//                 color: AppColor.white,
//                 borderRadius: BorderRadius.circular(16),
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//
//
//                 child: SizedBox(
//                   width: 140,
//                     child: Text('ابدأ الان',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 25,
//                             color: AppColor.primaryColor))),
//                     onPressed: (){
//
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
//                     }),
//           )
//         ]),
//       ),
//     );
//   }
// }
