//============================Map Keys==============================//
import '../models/HomeScreenModel.dart';

const addressKey = 'address';
const shippingMethodKey = 'shippingMethod';
const shippingIdKey = "shippingId";
const shippingAddressIdKey = "shippingAddressId";
const customerIdKey = "customerId";
const urlKey = 'url';
const fromHomePageKey = "fromHomePage";
const productIdKey = "productId";
const productNameKey = "productName";
const productImageKey = "productImage";
const subCategoryListKey = "subCategoryList";
const addressEndpointKey = "addressEndpoint";
const templateIdKey = "templateId";
const categoryNameKey = "categoryName";
const fromNotificationKey = "fromNotification";
const domainKey = "domain";


//===============================================================//

Map<String, dynamic> getCheckoutMap(
    int shippingId, int shippingAddressId, String addressEndpoint) {
  Map<String, dynamic> args = {};
  args[addressEndpointKey] = addressEndpoint;
  args[shippingAddressIdKey] = shippingAddressId;
  args[shippingIdKey] = shippingId;
  return args;
}

Map<String, dynamic> getCatalogMap(
     String url, bool fromHomepage,String categoryName,{bool fromNotification = false, String domain = "",int customerId = 0}) {
  Map<String, dynamic> args = {};
  args[customerIdKey] = customerId;
  args[urlKey] = url;
  args[fromHomePageKey] = fromHomepage;
  args[categoryNameKey] = categoryName;
  args[fromNotificationKey] = fromNotification;
  args[domainKey] = domain;
  return args;
}

Map<String, dynamic> getProductDataMap(String productName, String productId) {
  Map<String, dynamic> args = {};
  args[productNameKey] = productName;
  args[productIdKey] = productId;
  return args;
}

Map<String, dynamic> subCategoryDataMap(
    List<Children>? subCategoryList, int? customerId,String categoryName) {
  Map<String, dynamic> args = {};
  args[subCategoryListKey] = subCategoryList;
  args[customerIdKey] = customerId;
  args[categoryNameKey] = categoryName;
  return args;
}

Map<String, dynamic> getReviewDataMap(String productName, String thumbNail, int templateId){
  Map<String, dynamic> args = {};
  args[productNameKey] = productName;
  args[productImageKey] = thumbNail;
  args[templateIdKey] = templateId;
  return args;
}

