import 'dart:convert';

import 'package:flutter_project_structure/models/OrderReviewModel.dart';
import 'package:flutter_project_structure/models/PlaceOrderModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

import '../../../../models/PaymentModel.dart';


abstract class PaymentReviewScreenRepository{
  Future<PaymentModel> getPaymentMethod();
  Future<OrderReviewModel> getOrderReviewData(int shippingAddressId, int acquirerId, int shippingId);
  Future<PlaceOrderModel> placeOrder(String paymentRefrence, int transactionId, String paymentStatus);
}

class PaymentReviewScreenRepositoryImp implements PaymentReviewScreenRepository{
  @override
  Future<PaymentModel> getPaymentMethod() async{
    PaymentModel model;
    model = await ApiClient().getPaymentMethods();
    return model;
  }

  @override
  Future<OrderReviewModel> getOrderReviewData(int shippingAddressId, int acquirerId, int shippingId) async{
    OrderReviewModel model;
    Map<String, dynamic> data = {};
    data['shippingAddressId'] = shippingAddressId;
    data['acquirerId'] = acquirerId;
    data['shippingId'] = shippingId;
    String body = json.encode(data);
    model = await ApiClient().getOrderReviewData(body);
    return model;
}

  @override
  Future<PlaceOrderModel> placeOrder(String paymentRefrence, int transactionId, String paymentStatus) async{
    PlaceOrderModel model;
    Map<String, dynamic> data = {};
    data['paymentReference'] = paymentRefrence;
    data['transaction_id'] = transactionId;
    data['paymentStatus'] = paymentStatus;
    String body = json.encode(data);
    model = await ApiClient().placeOrder(body);
    return model;
  }
}