import 'package:dio/dio.dart';
import 'package:epic_expolre/core/api/AllplacesAPI.dart';
import 'package:epic_expolre/core/api/Recommended.dart';
import 'package:epic_expolre/core/models/user_models/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/Location_utlis/location_utils.dart';

part 'states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInit());

  Location? location;

  Future<void> getCurrentLocation() async {
    final position = LocationUtils.currentPosition;
    if (position == null) {
      return;
    }
    emit(HomeLoading());
    try {
      final baseURL = 'http://api.weatherapi.com/v1/current.json';
      final params = '?q=${position.latitude}, ${position.longitude}';
      final apiKey = '&key=d0ebe8c2c6544e9a9be172025231009';
      final response = await Dio().get(baseURL + params + apiKey);
      location = Location.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    emit(HomeInit());
  }


}



class PlaceController {
  List<Recommended> filterPlaces(String query, List<Recommended> places) {
    if (query.isEmpty) {
      return places;
    }

    return places.where((place) {
      final nameLower = place.name!.toLowerCase();
      final addressLower = place.address!.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) || addressLower.contains(searchLower);
    }).toList();
  }
}
