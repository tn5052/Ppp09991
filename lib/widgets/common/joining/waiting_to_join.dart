import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:talenties/utils/spacer.dart';

class WaitingToJoin extends StatelessWidget {
  const WaitingToJoin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image(
            //     image: AssetImage(
            //         "../../../../assets/images/app_launcher_icon.PNG")),
            // Lottie.asset("../../../../assets/jsons/joining_lottie.json",
            //     width: 100),
            const VerticalSpacer(20),
            const Text("Creating a Room",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
