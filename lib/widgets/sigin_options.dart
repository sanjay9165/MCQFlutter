import 'package:flutter/material.dart';

import '../manager/font_manager.dart';
import '../manager/image_manager.dart';
import '../utils/screen_dimensions.dart';



class SignInOptions extends StatelessWidget {
  const SignInOptions({super.key});

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      width: getDimension(context: context).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 300,
            child: Row(
              children: [
                const SizedBox(
                    width: 120,
                    child: Divider(
                      endIndent: 10,
                      color: Colors.grey,
                    )),
                Text("Or With", style: appFonts.f14w400Grey,
                  textAlign: TextAlign.center,),
                const SizedBox(
                    width: 120,
                    child: Divider(
                      color: Colors.grey,
                      indent: 10,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  color: Colors.white,
                  elevation: 10,
                  child: Image.asset(
                    appImages.faceBook,),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(appImages.google),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}