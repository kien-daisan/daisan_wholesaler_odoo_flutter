import 'package:flutter_project_structure/models/OrderDetailModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';



abstract class OrderDetailRepository {
  Future<OrderDetailModel> getOrderDetails(String orderEndpoint);
}

class OrderDetailRepositoryImp implements OrderDetailRepository {
  @override
  Future<OrderDetailModel> getOrderDetails(String orderEndPoint) async {
    try {
      OrderDetailModel? model;
      model = await ApiClient().orderDetails(orderEndPoint);
      return model;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
