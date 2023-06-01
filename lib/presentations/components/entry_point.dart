// import 'dart:math';

// import 'package:flutter/material.dart';
// // import 'package:rive/rive.dart';
// // import 'package:rive_animation/components/side_menu.dart';
// // import 'package:rive_animation/constants.dart';
// // import 'package:rive_animation/screens/home/home_screen.dart';
// // import 'package:rive_animation/utils/rive_utils.dart';

// import '../../models/loginmodel.dart';
// // import '../../utils/components/animated_bar.dart';
// // import '../../utils/models/menu_btn.dart';
// // import '../../utils/models/rive_asset.dart';
// import '../screens/home.dart';
// import 'side_menu.dart';

// class EntryPoint extends StatefulWidget {
//   const EntryPoint({super.key});

//   @override
//   State<EntryPoint> createState() => _EntryPointState();
// }

// class _EntryPointState extends State<EntryPoint>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> animation;
//   late Animation<double> scalAnimation;

//   // late SMIBool isSideBarClosed;

//   bool isSideMenuClosed = true;

//   @override
//   void initState() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 200),
//     )..addListener(() {
//         setState(() {});
//       });

//     animation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//           parent: _animationController, curve: Curves.fastOutSlowIn),
//     );
//     scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
//       CurvedAnimation(
//           parent: _animationController, curve: Curves.fastOutSlowIn),
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   late final LoginModel model;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: backgroundColor2,
//       resizeToAvoidBottomInset: false,
//       extendBody: true,
//       body: Stack(
//         children: [
//           AnimatedPositioned(
//             duration: const Duration(milliseconds: 200),
//             curve: Curves.fastOutSlowIn,
//             width: 288,
//             left: isSideMenuClosed ? -288 : 0,
//             height: MediaQuery.of(context).size.height,
//             child: const SideMenu(),
//           ),
//           Transform(
//             alignment: Alignment.center,
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, 0.001)
//               ..rotateY(animation.value - 30 * animation.value * pi / 180),
//             child: Transform.translate(
//               offset: Offset(animation.value * 265, 0),
//               child: Transform.scale(
//                 scale: scalAnimation.value,
//                 child: const ClipRRect(
//                   borderRadius: BorderRadius.all(Radius.circular(24)),

//                   // child: ChatScreen(model: model),
//                 ),
//               ),
//             ),
//           ),
//           // AnimatedPositioned(
//           //   duration: Duration(milliseconds: 200),
//           //   curve: Curves.fastOutSlowIn,
//           //   left: isSideMenuClosed ? 0 : 220,
//           //   top: 16,
//           //   child: MenuBtn(
//           //     riveOnInit: (artboard) {
//           //       StateMachineController controller = RiveUtils.getRiveController(
//           //           artboard,
//           //           stateMachineName: "State Machine");
//           //       isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
//           //       isSideBarClosed.value = true;
//           //     },
//           //     press: () {
//           //       isSideBarClosed.value = !isSideBarClosed.value;
//           //       if (isSideMenuClosed) {
//           //         _animationController.forward();
//           //       } else {
//           //         _animationController.reverse();
//           //       }
//           //       setState(() {
//           //         isSideMenuClosed = isSideBarClosed.value;
//           //       });
//           //     },
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
