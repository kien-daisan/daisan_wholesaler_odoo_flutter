import 'package:dio/dio.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/encryption.dart';
import 'package:flutter_project_structure/helper/extension.dart';
import 'package:flutter_project_structure/models/AccountInfoModel.dart';
import 'package:flutter_project_structure/models/AddressDetailModel.dart';
import 'package:flutter_project_structure/models/AddressListModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/CartViewModel.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/models/GooglePlaceModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/models/LoginResponseModel.dart';
import 'package:flutter_project_structure/models/NotificationModel.dart';
import 'package:flutter_project_structure/models/OrderModel.dart';
import 'package:flutter_project_structure/models/OrderDetailModel.dart';
import 'package:flutter_project_structure/models/OrderReviewModel.dart';
import 'package:flutter_project_structure/models/PaymentModel.dart';
import 'package:flutter_project_structure/models/PlaceOrderModel.dart';
import 'package:flutter_project_structure/models/ProductScreenModel.dart';
import 'package:flutter_project_structure/models/ReviewListModel.dart';
import 'package:flutter_project_structure/models/SearchScreenModel.dart';
import 'package:flutter_project_structure/models/SignUpScreenModel.dart';
import 'package:flutter_project_structure/models/SignUpTermsModel.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/models/WishlistModel.dart';
import 'package:flutter_project_structure/networkManager/apis.dart';
import 'package:flutter_project_structure/networkManager/dio_exceptions.dart';
import 'package:retrofit/http.dart';

import '../models/ShippingMethodModel.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class ApiClient {
  factory ApiClient({String? baseUrl}) {
    Dio dio = Dio();

    // dio.interceptors.add(CookieManager(PersistCookieJar(
    //     ignoreExpires: true,
    //     persistSession: true,
    //     storage: FileStorage(AppConstant.appDocPath + "/.cookies"))));
    dio.options = BaseOptions(
        receiveTimeout: 50000,
        connectTimeout: 50000,
        baseUrl: ApiConstant.baseUrl);
    // dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["Content-Type"] = "text/plain";
    dio.options.headers["Authorization"] =
        "Basic ${generateEncodedApiKey(ApiConstant.baseData)}";
    if (AppSharedPref().getLoginKey() != null) {
      dio.options
              .headers[AppSharedPref().getIsSocialLogin() ? "Login" : "Login"] =
          AppSharedPref().getLoginKey()!;
    }
    if (AppSharedPref().getAppLanguage() != null) {
      dio.options.headers["lang"] = AppSharedPref().getAppLanguage()!;
    }

    RequestOptions? reqOptions;
    dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      reqOptions = options;
      return handler.next(options);
    }, onResponse: (response, handler) async {
      checkCartAndEmailVerification(response);
      return handler.next(response);
    }, onError: (DioError e, handler) {
      retryApiFromClient(e, reqOptions, dio, handler);
      // return handler.next(err);
    }));
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @FormUrlEncoded()
  @POST(Apis.getHomePage)
  Future<HomePageData> getHomePageData(@Field() String apiKey,  @Body() String data);

  @FormUrlEncoded()
  @POST(Apis.getSplashData)
  Future<SplashScreenModel> getSplashData(@Field() String apiKey);

  @FormUrlEncoded()
  @POST(Apis.getProductData)
  Future<ProductScreenModel> getProductData(
      @Field() String apiKey, @Path() String templateId);

  @POST(Apis.getCatalogProducts)
  Future<CategoryScreenModel> getCatalogData(@Body() String data);

  @POST(Apis.customerSignUp)
  Future<SignUpScreenModel> getCustomerSignUp(@Body() String data);

  @FormUrlEncoded()
  @POST(Apis.customerLogin)
  Future<LoginResponseModel> getCustomerLogIn(@Header("Login") String login,
      @Body() String data, @Header("Content-Type") String type);

  @POST(Apis.forgetPassword)
  Future<BaseModel> forgetPassword(@Body() String data);

  @FormUrlEncoded()
  @POST("{endpoint}")
  Future<CategoryScreenModel> getProductSliderData(@Path() String endpoint,
      @Body() String data, @Header("Content-Type") String content_type);

  @POST(Apis.getReviewList)
  Future<ReviewListModel> getReviewList(@Body() String data);

  @POST(Apis.likeDislikeReview)
  Future<BaseModel> likeDislikeReview(@Body() String data);

  @POST(Apis.myCart)
  Future<CartViewModel> getCartData();

  @DELETE(Apis.myCart + "{lineId}")
  Future<BaseModel> removeCartItem(@Path() int lineId);

  @POST(Apis.addToWishlist)
  Future<BaseModel> addToWishlist(
      @Header("Content-Type") String content_type, @Body() String data);

  @DELETE(Apis.removeWishlist + "{productId}")
  Future<BaseModel> removeItemFromWishlist(@Path() String productId);

  @POST(Apis.addToCart)
  Future<BaseModel> addToCart(
      @Body() String data, @Header("Content-Type") String content_type);

  @POST(Apis.cartToWishlist)
  Future<BaseModel> cartToWishlist(
      @Body() String data, @Header("Content-Type") String content_type);

  @DELETE(Apis.setCartEmpty)
  Future<BaseModel> setCartEmpty();

  @PUT(Apis.myCart + "{lineId}")
  Future<BaseModel> setCartItemQuantity(
      @Path() int lineId, @Body() String data);

  @POST(Apis.addReview)
  Future<BaseModel> addReview(
      @Header("Content-Type") String content_type, @Body() String data);

  @POST(Apis.logOut)
  Future<BaseModel> logOut();

  @POST(Apis.addressList)
  Future<AddressListModel> getAddressList();

  @DELETE(Apis.deleteAddress)
  Future<BaseModel> deleteAddress(@Path() String addressId);

  @POST(Apis.countryList)
  Future<CountryListModel> getCountryList();

  @GET(Apis.shippingMethods)
  Future<ShippingMethodModel> getShippingMethods();

  @POST(Apis.paymentMethods)
  Future<PaymentModel> getPaymentMethods();

  @POST("{endpoint}")
  Future<AddressDetailModel> getAddressDetails(@Path() String endpoint);

  @PUT("{endpoint}")
  Future<BaseModel> updateAddress(@Path() String endpoint, @Body() String data);

  @POST(Apis.addNewAddress)
  Future<BaseModel> addNewAddress(@Body() String data);

  @POST(Apis.orderReview)
  Future<OrderReviewModel> getOrderReviewData(@Body() String data);

  @POST(Apis.placeOrder)
  Future<PlaceOrderModel> placeOrder(@Body() String data);

  @POST(Apis.myWishlist)
  Future<WishlistModel> getWishlistItems();

  @POST(Apis.wishlistToCart)
  Future<BaseModel> moveWishlistToCart(@Body() String data);

  @POST("{endpoint}")
  Future<OrderDetailModel> orderDetails(@Path() String endpoint);

  @POST(Apis.orderList)
  Future<OrderModel> getOrderList(@Body() String data);

  @POST(Apis.saveAccountInfo)
  Future<AccountInfoModel> saveAccountInfo(@Body() String data);

  @POST(Apis.deactivateAccount)
  Future<AccountInfoModel> deactivateAccount(@Body() String data);

  @GET(Apis.downloadInfo)
  Future<AccountInfoModel> downloadInfo();

  @PUT(Apis.saveDefaultShippingAddress + "{endPoint}")
  Future<BaseModel> saveDefaultShippingAddress(@Path() String endPoint);

  @POST(Apis.resendVerification)
  Future<BaseModel> resendVerification();

  @POST(Apis.notificationsList)
  Future<NotificationModel> getNotificationData();

  @POST(Apis.markReadNotification + "{endPoint}")
  Future<NotificationList> markReadNotification(
      @Path() String endPoint, @Body() String data);

  @DELETE(Apis.markReadNotification + "{endPoint}")
  Future<NotificationList> deleteNotification(@Path() String endPoint);

  @POST(Apis.search)
  Future<SearchScreenModel> getSearchList(@Body() String data);

  @POST(Apis.deleteAccount)
  Future<BaseModel> deleteAccount(@Body() String data);

  @DELETE(Apis.deleteProfileImage)
  Future<BaseModel> deleteProfileImage();

  @DELETE(Apis.deleteBannerImage)
  Future<BaseModel> deleteBannerImage();

  @GET(Apis.googlePlace + "{endPoint}")
  Future<GooglePlaceModel> getGooglePlace(@Path() String endPoint);

  @GET(Apis.signUpTerms)
  Future<SignUpTermsModel> getSignUpTerms();
}
