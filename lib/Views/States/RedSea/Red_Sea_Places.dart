import 'package:dio/dio.dart';
import 'package:epic_expolre/core/app_colors/app_colors.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:epic_expolre/Widgets/app_AppBar.dart';
import 'package:epic_expolre/Widgets/app_card.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/API_App_card.dart';
import '../../../core/api/AlexTripAPI.dart';
import '../../../core/api/const_end_ponits.dart';
import '../../../core/models/AlexPlacesAPI.dart';
import '../../../core/models/CairoPlacesAPI.dart';
import '../../../core/models/RedSeaPlacesAPI.dart';

class RedSeaPlacesScreen extends StatefulWidget {
  const RedSeaPlacesScreen({Key? key});

  @override
  State<RedSeaPlacesScreen> createState() => _RedSeaPlacesScreenState();
}

class PlaceAPI {
  final String baseUrl = EndPoint.baseUrl;

  Future<List<RedSeaPlaces>> getAllTrips({int page = 1}) async {
    final BaseOptions baseOptions = BaseOptions(headers: {
      "Authorization": "Bearer 15|itUINYzlaSxfVOyDVMUjhlRrl2civqwiVs1yLwnTa95864a8",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    });
    final Dio dio = Dio(baseOptions);

    try {
      Response response = await dio.get('${baseUrl}api/user/place/red-sea?page=$page');
      if (response.statusCode == 200) {
        print(response.data);
        final dynamic responseData = response.data;
        final dynamic allPlacesData = responseData['data']['places'];

        if (allPlacesData is List) {
          List<RedSeaPlaces> places = allPlacesData.map((e) => RedSeaPlaces.fromJson(e)).toList();
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

class _RedSeaPlacesScreenState extends State<RedSeaPlacesScreen> {
  List<RedSeaPlaces>? redseaplaces=[];
  bool isloading = true;
  PlaceAPI placeAPI = PlaceAPI();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _fetchPlaces();
  }

  void _fetchPlaces() async {
    try {
      List<RedSeaPlaces> fetchedPlaces = await placeAPI.getAllTrips(page: currentPage);
      setState(() {
        redseaplaces = fetchedPlaces;
        isloading = false;
      });
    } catch (e) {
      print('Error fetching places: $e');
    }
  }

  void goToNextPage() {
    setState(() {
      currentPage += 1;
      redseaplaces = null;
      isloading = true;
    });
    _fetchPlaces();
  }

  void goToPreviousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage -= 1;
        redseaplaces = null;
        isloading = true;
      });
      _fetchPlaces();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: redseaplaces!.length,
        itemBuilder: (context, index) => APIAppCard(
          cardText: redseaplaces![index].name!,
          cardAddress: redseaplaces![index].address!,
          cardimgUrl: redseaplaces![index].img_url!,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.blue)),
              onPressed: goToPreviousPage,
              child: Text('Previous Page'),
            ),
            Text('Page $currentPage'),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.blue)),
              onPressed: goToNextPage,
              child: Text('Next Page'),
            ),
          ],
        ),
      ),
    );
  }
}