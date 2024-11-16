import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gf/src/routes/app_routes.dart';
import 'package:gf/src/shared/colors/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../login/routes/auth_router.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,

    curve: Curves.easeIn,
  );
  void redirect(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AuthRouter())
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    redirect(context);
    return Scaffold(
      backgroundColor: AppColors.initialPageBackground2,
      body: SafeArea(
          child: Center(
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text("Gerencie",
                        style: TextStyle(
                            color: AppColors.loginAppText,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                  ),
                  RotationTransition(
                    turns: _animation,
                    child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          MdiIcons.chefHat,
                          size: 150,
                          color: AppColors.initialPageItem,
                        )),
                  )
                ],
              ),
            ),
          )),
    );
  }
}