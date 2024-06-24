import 'package:dio/dio.dart';
import 'package:epic_expolre/core/app_colors/app_colors.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:epic_expolre/Widgets/app_AppBar.dart';
import 'package:epic_expolre/Widgets/app_card.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/API_App_card.dart';
import '../../../cache/cache_helper.dart';
import '../../../core/api/AlexTripAPI.dart';
import '../../../core/api/const_end_ponits.dart';
import '../../../core/models/AlexPlacesAPI.dart';
import '../../../core/models/CairoPlacesAPI.dart';
import 'model/luxor_places_model.dart';

class LuxorPlacesScreen extends StatefulWidget {
  const LuxorPlacesScreen({Key? key});

  @override
  State<LuxorPlacesScreen> createState() => _LuxorPlacesScreenState();
}

class PlaceAPI {
  final String baseUrl = EndPoint.baseUrl;

  Future<List<LuxorPlaces>> getAllTrips() async {
    final BaseOptions baseOptions = BaseOptions(headers: {
      "Authorization": "Bearer ${CacheHelper().getData(key: ApiKey.token)}",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    });
    final Dio dio = Dio(baseOptions);

    try {
      Response response = await dio.get('${baseUrl}api/user/place/luxor');
      if (response.statusCode == 200) {
        print(response.data);
        final dynamic responseData = response.data;
        final dynamic allPlacesData = responseData['places'];

        if (allPlacesData is List) {
          List<LuxorPlaces> places = allPlacesData.map((e) => LuxorPlaces.fromJson(e)).toList();
          return places;
        } else {
          throw Exception('Invalid data format: allPlaces is not a List');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      log("${e.response}");
      throw Exception('${e.toString()}');
    }
  }
}

class _LuxorPlacesScreenState extends State<LuxorPlacesScreen> {
  List<LuxorPlaces> allLuxorPlaces = [];
  List<LuxorPlaces> displayedLuxorPlaces = [];
  bool isLoading = true;
  PlaceAPI placeAPI = PlaceAPI();
  int currentPage = 1;
  final int itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _fetchPlaces();
  }

  void _fetchPlaces() async {
    try {
      List<LuxorPlaces> fetchedPlaces = await placeAPI.getAllTrips();
      setState(() {
        allLuxorPlaces = fetchedPlaces;
        _updateDisplayedPlaces();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching places: $e');
    }
  }

  void _updateDisplayedPlaces() {
    int start = (currentPage - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    setState(() {
      displayedLuxorPlaces = allLuxorPlaces.sublist(start, end > allLuxorPlaces.length ? allLuxorPlaces.length : end);
    });
  }

  void goToNextPage() {
    if (currentPage * itemsPerPage < allLuxorPlaces.length) {
      setState(() {
        currentPage += 1;
        _updateDisplayedPlaces();
      });
    }
  }

  void goToPreviousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage -= 1;
        _updateDisplayedPlaces();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: AppColors.blue))
          : ListView.builder(
        itemCount: displayedLuxorPlaces.length,
        itemBuilder: (context, index) => APIAppCard(
          cardText: displayedLuxorPlaces[index].name!,
          cardAddress: displayedLuxorPlaces[index].address!,
          cardimgUrl: displayedLuxorPlaces[index].img_url!,
          cardid: displayedLuxorPlaces[index].id!,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                goToPreviousPage();
              },
              child: CircleAvatar(
                backgroundColor: AppColors.blue,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: AppColors.grey),
              ),
              child: Text('$currentPage'),
            ),
            InkWell(
              onTap: () {
                goToNextPage();
              },
              child: CircleAvatar(
                backgroundColor: AppColors.blue,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
