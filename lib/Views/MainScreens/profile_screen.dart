import 'package:flutter/material.dart';

import '../../Widgets/bottomNavigationBar.dart';
import '../../core/app_colors/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.gray, width: 1),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: AppColors.gray,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => bottomNavigationBar(),));
              },
            ),
          ),
        ),
        title: Text(
          "    Profile",
          style: TextStyle(
            color: AppColors.Black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(child: Text("Profile")),
    );
  }
}
