import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/encryption.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class SplashScreenRepository{
  Future<SplashScreenModel> getSplashData();
}

class SplashscreenRepositoryImp implements SplashScreenRepository{
  @override
  Future<SplashScreenModel> getSplashData() async{
    try{
      SplashScreenModel? splashScreenModel;
      splashScreenModel = await ApiClient().getSplashData(generateEncodedApiKey(ApiConstant.baseData));
      return splashScreenModel;
    }catch(e){
      print(e);
      throw Exception(e);

    }

  }

}