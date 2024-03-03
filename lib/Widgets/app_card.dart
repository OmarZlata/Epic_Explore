import 'package:flutter/material.dart';

import '../core/app_colors/app_colors.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24,),
        Container(
          child: Center(
            child: Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 348,
                height: 148,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/JulyGetaway.png'),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Classic Lorem ipsum"),
                                SizedBox(
                                  width: 36,
                                ),
                                InkWell(
                                  child: Image.asset('assets/images/dots.png'),
                                  onTap: () {
                                    print("Delete");
                                  },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            Text("dolor"),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.Blue,
                                ),
                                Text(
                                  "Alexandria ,Egypt",
                                  style: TextStyle(
                                      fontSize: 12, color: AppColors.gray),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.Blue,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text("\$14.4"),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.favorite, color: Colors.red),
                                    Text(
                                      "294 Likes",
                                      style: TextStyle(
                                          fontSize: 12, color: AppColors.gray),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Row(
                                  children: [
                                    Image.asset('assets/images/rate.png'),
                                    Text("4.5"),
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),

            ),
          ),
        ),
      ],

    );
  }
}
