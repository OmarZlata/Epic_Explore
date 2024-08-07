import 'package:epic_expolre/Views/States/alex/hotels_screen.dart';
import 'package:epic_expolre/Views/States/alex/trips_screen.dart';
import 'package:epic_expolre/Widgets/app_text.dart';
import 'package:epic_expolre/core/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class StatesTabBar extends StatelessWidget {
  const StatesTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 1,
          title: Text(
            "Alexandra",
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
                    color: AppColors.grey.withOpacity(.2)),
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
                          title: 'Trips',
                        )),
                    Tab(
                        child: AppText(
                          title: 'Hotels  ',
                        )),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  TripsView(),
                  HotelsView(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
