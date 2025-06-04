// import 'dart:async';
// import 'package:flutter/material.dart';
// // import './landing_screen.dart';
// // import '../utils/helper.dart';
// // import './home_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState(); // ✅ Corrected way to create state
// }

// class _SplashScreenState extends State<SplashScreen> {
//   late Timer _timer; // ✅ Fixed null safety issue

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer(const Duration(milliseconds: 4000), () {
//       Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel(); // ✅ Prevents memory leaks
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: const Color(0xFFB2FBA5),
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset(
//                 "assets/images/main/logo.png", // ✅ Tree Logo
//                 height: 250,
//                 width: 250,
//               ),
//               //   ],
//               // ),
//               const SizedBox(height: 10), // ✅ Spacing
//               Text(
//                 "Crop-Guard",
//                 style: Theme.of(
//                   context,
//                 ).textTheme.headlineMedium, // ✅ Uses theme's titleLarge
//               ),
//               const SizedBox(height: 10), // ✅ Spacing
//               Text(
//                 "Smart Farming Assistant",
//                 style: Theme.of(
//                   context,
//                 ).textTheme.titleMedium, // ✅ Uses theme's titleLarge
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
