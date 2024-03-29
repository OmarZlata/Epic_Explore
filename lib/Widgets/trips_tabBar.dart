import 'package:epic_expolre/Widgets/app_text.dart';
import 'package:epic_expolre/core/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../Views/My_Trips/future.dart';
import '../Views/My_Trips/present.dart';
import '../Views/My_Trips/previous.dart';
  class TripsTabBar extends StatefulWidget {
  const TripsTabBar({super.key});

  @override
  State<TripsTabBar> createState() => _TripsTabBarState();
}

class _TripsTabBarState extends State<TripsTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 1,
          title: Text(
            "My Trips",
            style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.gray.withOpacity(.2)),
                child: TabBar(
                  indicatorPadding: EdgeInsets.only(left:15 ,right:15,top: 6,bottom: 6,),
                  splashBorderRadius: BorderRadius.circular(12),
                  indicator: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelColor: AppColors.white,
                  unselectedLabelColor: AppColors.black,
                  tabs: [
                    Tab(
                        child: AppText(
                      title: 'Previous',
                    )),
                    Tab(
                        child: AppText(
                      title: 'Present',
                    )),
                    Tab(
                        child: AppText(
                      title: 'Future',
                    )),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  PreviousScreen(),
                  PresentScreen(),
                  FutureScreen(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
