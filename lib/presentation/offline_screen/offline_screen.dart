import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/image_manager.dart';
import 'package:mcq/manager/space_manager.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              appImages.offlineAnimation,
              height: 300,
            ),
            appSpaces.spaceForHeight25,
            Text(
              'Please Check Your Internet Connection',
              style: appFonts.f16w600Black,
            )
          ],
        ),
      ),
    );
  }
}
