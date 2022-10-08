import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/models/GooglePlaceModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class LocationRepository {
  Future<GooglePlaceModel> getPlace(String text);
}

class LocationRepositoryImp implements LocationRepository {
  @override
  Future<GooglePlaceModel> getPlace(String text) async {
    GooglePlaceModel? model;
    String endPoint = "$text&key=${AppConstant.googleKey}";
    model = await ApiClient(baseUrl: "https://maps.googleapis.com/maps/api/")
        .getGooglePlace(endPoint);
    return model;
  }
}
