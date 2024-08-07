import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text.dart';
import '../../core/app_colors/app_colors.dart';
import '../../generated/l10n.dart';
import 'onboarding_2.dart';

class WelcomeScreen1 extends StatelessWidget {
  const WelcomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 430,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/Frame.png',
                    width: 1000,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    child: Image.asset(
                      'assets/images/Welcome3.png',
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
            AppText(
              title: S.of(context).welcome,
              color: AppColors.black,
              fontSize: 22 ,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 10,),
            AppText(
              title:S.of(context).exploreIntro,
              color: AppColors.grey,
              fontSize: 18 ,

            ),
            AppText(
              title: S.of(context).planAdventure,
              color: AppColors.grey,
              fontSize: 18 ,

            ),
            SizedBox(height:24 ,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/indicators1.png')

              ],),
            Spacer(),
            AppButton(
              title: S.of(context).next,
              color: AppColors.blue,
              font_color: AppColors.white,
              onTap: () {
                Navigator.pushReplacement(

                    context,
                    MaterialPageRoute(
                      builder: (context) => WelcomeScreen2(),
                    ));
              },
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}
