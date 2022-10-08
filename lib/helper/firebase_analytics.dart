import 'package:firebase_analytics/firebase_analytics.dart';



class AnalyticsEventsFirebase {

  ///Add To cart event///
  addCartEvent(String productId, String name, int quantity, {String?category}) {
    FirebaseAnalytics.instance.logAddToCart(
        items: [
          AnalyticsEventItem(itemId: productId,
              itemName: name,
              quantity: quantity,
              itemCategory: category)
        ]);
  }


  ///WishList Event///
  addWishListEvent(String productId, String name, int quantity,
      {String? category}) {
    FirebaseAnalytics.instance.logAddToWishlist(
        items: [
          AnalyticsEventItem(itemId: productId,
              itemName: name,
              quantity: quantity,
              itemCategory: category)
        ]);
  }


  ///Order Purchase Event///
  orderPurchase() {
    FirebaseAnalytics.instance.logEvent(name: "purchase", parameters: null);
  }


  ///SignUp Event///
  signUpEvent(String dataModel) {
    FirebaseAnalytics.instance.logSignUp(signUpMethod: dataModel);
  }


  ///Login Event///
  loginEvent() {
    FirebaseAnalytics.instance.logLogin();
  }

  appOpenEvent() {
    FirebaseAnalytics.instance.logAppOpen();
  }

  screenView(String screenName, String className) {
    FirebaseAnalytics.instance.logScreenView(
        screenName: screenName, screenClass: className);
  }

  removeFromCart(String productId, String name,) {
    FirebaseAnalytics.instance.logRemoveFromCart(
        items: [ AnalyticsEventItem(itemId: productId, itemName: name,)]);
  }

  checkOut(String productId, String name, int quantity, String currency,
      String coupon) {
    FirebaseAnalytics.instance.logBeginCheckout(currency: currency,
        items: [
          AnalyticsEventItem(
              itemId: productId, itemName: name, quantity: quantity)
        ],
        coupon: coupon);
  }

  productEvent(String productId, String name) {
    FirebaseAnalytics.instance.logViewItem(
        items: [ AnalyticsEventItem(itemId: productId, itemName: name)]);
  }

  setUserIUd() {
    FirebaseAnalytics.instance.setUserId();
  }

  searchEvent(String searchTerm) {
    FirebaseAnalytics.instance.logSearch(searchTerm: searchTerm);
  }

  shareEvent(String contentType, String itemId, String method) {
    FirebaseAnalytics.instance.logShare(
        contentType: contentType, itemId: itemId, method: method);
  }

  setUserProperty(String name, String email) {
    FirebaseAnalytics.instance.setUserProperty(name: name, value: email);
  }

  logPaymentInfo(String paymentType) {
    FirebaseAnalytics.instance.logAddPaymentInfo(paymentType: paymentType);
  }

  logShippingInfo(String shippingMethod) {
    FirebaseAnalytics.instance.logAddShippingInfo(shippingTier: shippingMethod);
  }

  purchaseItemEvent(String productId, String name) {
    FirebaseAnalytics.instance.logPurchase(
        items: [ AnalyticsEventItem(itemId: productId, itemName: name)]);
  }

  // ecommercePurchase(String productId,String name){
  //   FirebaseAnalytics.instance.logEcommercePurchase(items:[ AnalyticsEventItem(itemId:productId,itemName: name)]);
  // }
  viewCartEvent(String productId, String name) {
    FirebaseAnalytics.instance.logViewCart(
        items: [ AnalyticsEventItem(itemId: productId, itemName: name)]);
  }

  viewCategory(List<AnalyticsEventItem>? items,) {
    FirebaseAnalytics.instance.logViewItemList(items: items,);
  }
}


