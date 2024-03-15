// import 'dart:convert';
//
//
// class RouteHelper {
//   static final FluroRouter router = FluroRouter();
//
//   static String splash = '/splash';
//   static String orderDetails = '/order-details';
//   static String onBoarding = '/on-boarding';
//   static String menu = '/';
//   static String login = '/login';
//   static String favorite = '/favorite';
//   static String forgetPassword = '/forget-password';
//   static String signUp = '/sign-up';
//   static String verification = '/verification';
//
//
//
//
//   static String getMainRoute() => menu;
//   static String getLoginRoute() => login;
//   static String getTermsRoute() => termsScreen;
//   static String getPolicyRoute() => policyScreen;
//   static String getAboutUsRoute() => aboutUsScreen;
//   static String getfaqRoute() => faqScreen;
//   static String getUpdateRoute() => update;
//   static String getSelectLocationRoute() => selectLocation;
//
//   static String getOrderDetailsRoute(String? id, {String? phoneNumber}) => '$orderDetails?id=$id&phone=${Uri.encodeComponent('$phoneNumber')}';
//   static String getVerifyRoute(String page, String email, {String? session}) {
//     String data = Uri.encodeComponent(jsonEncode(email));
//     String authSession = base64Url.encode(utf8.encode(session ?? ''));
//     return '$verification?page=$page&email=$data&data=$authSession';
//   }
//   static String getNewPassRoute(String? email, String token) => '$resetPassword?email=${Uri.encodeComponent('$email')}&token=$token';
//   //static String getAddAddressRoute(String page) => '$addAddress?page=$page';
//   static String getAddAddressRoute(String page, String action, AddressModel addressModel) {
//     String data = base64Url.encode(utf8.encode(jsonEncode(addressModel.toJson())));
//     return '$addAddressScreen?page=$page&action=$action&address=$data';
//   }
//   static String getUpdateAddressRoute(AddressModel addressModel,) {
//     String data = base64Url.encode(utf8.encode(jsonEncode(addressModel.toJson())));
//     return '$updateAddress?address=$data';
//   }
//   static String getPaymentRoute({String? id = '', String? url, PlaceOrderBody? placeOrderBody}) {
//     String uri = url != null ? Uri.encodeComponent(base64Encode(utf8.encode(url))) : 'null';
//     String data = placeOrderBody != null ? base64Url.encode(utf8.encode(jsonEncode(placeOrderBody.toJson()))) : '';
//     return '$payment?id=$id&uri=$uri&place_order=$data';
//   }
//   static String getCheckoutRoute(double amount, double? discount, String? type, String code, String freeDelivery, double deliveryCharge) =>
//       '$checkout?amount=${base64Encode(utf8.encode('$amount'))}&discount=${base64Encode(utf8.encode('$discount'))}&type=$type&code=${base64Encode(utf8.encode(code))}&c-type=${base64Encode(utf8.encode(freeDelivery))}&del_char=${base64Encode(utf8.encode('$deliveryCharge'))}';
//   static String getOrderTrackingRoute(int? id, String? phoneNumber) => '$trackOrder?id=$id&phone=${Uri.encodeComponent('$phoneNumber')}';
//
//   static String getCategoryProductsRouteNew({required String categoryId, String? subCategory}) {
//     return '$categoryProductsNew?category_id=$categoryId&subcategory=${Uri.encodeComponent(subCategory ?? '')}';
//   }
//   static String getProductDescriptionRoute(String description) => '$productDescription?description=$description';
//
//   static String getProductDetailsRoute({required int? productId, bool formSearch = false}) {
//     String fromSearch = jsonEncode(formSearch);
//
//     return '$productDetails?product_id=$productId&search=$fromSearch';
//   }
//   static String getProductImagesRoute(String? name, String images) => '$productImages?name=$name&images=$images';
//   static String getProfileEditRoute(UserInfoModel? userInfoModel) {
//     String? data;
//     if(userInfoModel != null){
//       data = base64Url.encode(utf8.encode(jsonEncode(userInfoModel.toJson())));
//     }
//     return '$profileEdit?user=$data';
//   }
//   static String getHomeItemRoute(String productType) {
//     return '$homeItem?item=$productType';
//   }
//
//   static String getmaintenanceRoute() => maintenance;
//   static String getSearchResultRoute(String text) {
//     List<int> encoded = utf8.encode(text);
//     String data = base64Encode(encoded);
//     return '$searchResult?text=$data';
//   }
//   static String getChatRoute({OrderModel? orderModel}) {
//     String orderModel0 = base64Encode(utf8.encode(jsonEncode(orderModel)));
//     return '$chatScreen?order=$orderModel0';
//   }
//   static String getContactRoute() => contactScreen;
//   static String getFavoriteRoute() => favorite;
//   static String getWalletRoute({String? token, String? status}) => '$wallet?token=$token&flag=$status';
//   static String getReferAndEarnRoute() => referAndEarn;
//   static String getReturnPolicyRoute() => returnPolicyScreen;
//   static String getCancellationPolicyRoute() => cancellationPolicyScreen;
//   static String getRefundPolicyRoute() => refundPolicyScreen;
//   static String getLoyaltyScreen() => loyaltyScreen;
//   static String getCreateAccount() => createAccount;
//   static String getCartScreen() => cart;
//
//
//   static final Handler _splashHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => const SplashScreen());
//
//   static final Handler _orderDetailsHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
//     OrderDetailsScreen? orderDetailsScreen = ModalRoute.of(context!)!.settings.arguments as OrderDetailsScreen?;
//     return _routeHandler(child: orderDetailsScreen ?? OrderDetailsScreen(
//       orderId: int.parse(params['id'][0]), orderModel: null,
//       phoneNumber: Uri.decodeComponent(params['phone'][0]),
//     ));
//   });
//
//   static final Handler _onBoardingHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(child: OnBoardingScreen()));
//
//   static final Handler _menuHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(child: const MenuScreen()));
//
//   static final Handler _loginHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(child: const LoginScreen()));
//
//   static final Handler _forgetPassHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(child: const ForgotPasswordScreen()));
//
//   static final Handler _signUpHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(child: const SignUpScreen()));
//
//   static final Handler _verificationHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
//
//     return _routeHandler(child: VerificationScreen(
//       fromSignUp: params['page'][0] == 'sign-up',
//       emailAddress: jsonDecode(params['email'][0]),
//       session: params['data'][0] == 'null' ? null : utf8.decode(base64Url.decode(params['data'][0].replaceAll(' ', '+'))),
//     ));
//   });
//
//   static final Handler _createAccountHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(
//     child: const CreateAccountScreen(),
//   ));
//
//
//
//   static final Handler _profileHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(child: const ProfileScreen()));
//
//   static final Handler _searchProductHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(child: const SearchScreen()));
//
//   static final Handler _profileEditHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
//     String decoded = utf8.decode(base64Url.decode(params['user'][0]));
//     return _routeHandler(child: ProfileEditScreen(userInfoModel: UserInfoModel.fromJson(jsonDecode(decoded))));
//   });
//
//   static final Handler _searchResultHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
//     List<int> decode = base64Decode(params['text'][0]);
//     String data = utf8.decode(decode);
//     return _routeHandler(child: SearchResultScreen(searchString: data));
//   });
//   static final Handler _cartHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(child: const CartScreen()));
//   static final Handler _categoriesHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
//     return _routeHandler(child: const Allcategoriescreen());
//   } );
//   static final Handler _profileMenusHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(child: const MenuWidget()));
//   static final Handler _myOrderHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(child: const MyOrderScreen()));
//   static final Handler _addressHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(child: const AddressScreen()));
//   static final Handler _couponHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(child: const CouponScreen()));
//   static final Handler _chatHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) {
//     final orderModel = jsonDecode(utf8.decode(base64Url.decode(params['order'][0].replaceAll(' ', '+'))));
//     return _routeHandler(child: ChatScreen(orderModel : orderModel != null ? OrderModel.fromJson(orderModel) : null));
//   });
//   static final Handler _settingsHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => _routeHandler(child: const SettingsScreen()));
//   static final Handler _termsHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const HtmlViewerScreen(htmlType: HtmlType.termsAndCondition)));
//
//   static final Handler _policyHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const HtmlViewerScreen(htmlType: HtmlType.privacyPolicy)));
//
//   static final Handler _aboutUsHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const HtmlViewerScreen(htmlType: HtmlType.aboutUs)));
//   static final Handler _faqHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const HtmlViewerScreen(htmlType: HtmlType.faq)));
//
//   static final Handler _homeItemHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) {
//     return _routeHandler(child: HomeItemScreen(productType: params['item'][0]));
//   });
//   static final Handler _maintenanceHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const MaintenanceScreen()));
//   static final Handler _contactHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const ContactScreen()));
//
//   static final Handler _updateHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const UpdateScreen()));
//   static final Handler _newAddressHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) {
//     bool isUpdate = params['action'][0] == 'update';
//     AddressModel? addressModel;
//     if(isUpdate) {
//       String decoded = utf8.decode(base64Url.decode(params['address'][0].replaceAll(' ', '+')));
//       addressModel = AddressModel.fromJson(jsonDecode(decoded));
//     }
//     return _routeHandler(child: AddNewAddressScreen(fromCheckout: params['page'][0] == 'checkout', isEnableUpdate: isUpdate, address: isUpdate ? addressModel : null));
//   });
//   static final Handler _favoriteHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const WishListScreen()));
//
//   static final Handler _walletHandler = Handler(
//     handlerFunc: (context, Map<String, dynamic> params) =>
//         _routeHandler(child: WalletScreen(token: params['token'][0], status: params['flag'][0])),
//   );
//
//   static final Handler _referAndEarnHandler = Handler(
//       handlerFunc: (context, Map<String, dynamic> params) =>
//           _routeHandler(child: const ReferAndEarnScreen(),)
//   );
//
//
//   static final Handler _returnPolicyHandler = Handler(
//     handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const HtmlViewerScreen(htmlType: HtmlType.returnPolicy)),
//   );
//
//   static final Handler _refundPolicyHandler = Handler(
//     handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const HtmlViewerScreen(htmlType: HtmlType.refundPolicy)),
//   );
//
//   static final Handler _cancellationPolicyHandler = Handler(
//     handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const HtmlViewerScreen(htmlType: HtmlType.cancellationPolicy)),
//   );
//
//   static final Handler _orderSearchHandler = Handler(
//     handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const OrderSearchScreen()),
//   );
//
//   static final Handler _notFoundHandler = Handler(
//     handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const NotFoundScreen()),
//   );
//   static final Handler _loyaltyHandler = Handler(
//     handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(child: const LoyaltyScreen()),
//   );
//
//
//
//   static void setupRouter(){
//     router.define(splash, handler: _splashHandler, transitionType: TransitionType.fadeIn);
//     router.define(orderDetails, handler: _orderDetailsHandler, transitionType: TransitionType.fadeIn);
//     router.define(onBoarding, handler: _onBoardingHandler, transitionType: TransitionType.fadeIn);
//     router.define(menu, handler: _menuHandler, transitionType: TransitionType.fadeIn);
//     router.define(login, handler: _loginHandler, transitionType: TransitionType.fadeIn);
//     router.define(forgetPassword, handler: _forgetPassHandler, transitionType: TransitionType.fadeIn);
//     router.define(signUp, handler: _signUpHandler, transitionType: TransitionType.fadeIn);
//     router.define(verification, handler: _verificationHandler, transitionType: TransitionType.fadeIn);
//     router.define(createAccount, handler: _createAccountHandler, transitionType: TransitionType.fadeIn);
//     router.define(resetPassword, handler: _resetPassHandler, transitionType: TransitionType.fadeIn);
//     router.define(updateAddress, handler: _updateAddressHandler, transitionType: TransitionType.fadeIn);
//    // router.define(selectLocation, handler: _selectLocationHandler, transitionType: TransitionType.fadeIn);
//     router.define('$orderSuccessful/:id/:status', handler: _orderSuccessHandler, transitionType: TransitionType.fadeIn);
//     router.define('$orderWebPayment/:status?:token', handler: _orderWebPaymentHandler, transitionType: TransitionType.fadeIn);
//     router.define('$wallet/:status?:flag::token', handler: _walletHandler, transitionType: TransitionType.fadeIn);
//
//     router.define(payment, handler: _paymentHandler, transitionType: TransitionType.fadeIn);
//     router.define(checkout, handler: _checkoutHandler, transitionType: TransitionType.fadeIn);
//     router.define(notification, handler: _notificationHandler, transitionType: TransitionType.fadeIn);
//     router.define(trackOrder, handler: _trackOrderHandler, transitionType: TransitionType.fadeIn);
//     router.define(categoryProductsNew, handler: _categoryProductsHandlerNew, transitionType: TransitionType.fadeIn);
//     router.define(productDescription, handler: _productDescriptionHandler, transitionType: TransitionType.fadeIn);
//     router.define(productDetails, handler: _productDetailsHandler, transitionType: TransitionType.fadeIn);
//     router.define(productImages, handler: _productImagesHandler, transitionType: TransitionType.fadeIn);
//     router.define(profile, handler: _profileHandler, transitionType: TransitionType.fadeIn);
//     router.define(searchProduct, handler: _searchProductHandler, transitionType: TransitionType.fadeIn);
//     router.define(profileEdit, handler: _profileEditHandler, transitionType: TransitionType.fadeIn);
//     router.define(searchResult, handler: _searchResultHandler, transitionType: TransitionType.fadeIn);
//     router.define(cart, handler: _cartHandler, transitionType: TransitionType.fadeIn);
//     router.define(categories, handler: _categoriesHandler, transitionType: TransitionType.fadeIn);
//     router.define(profileMenus, handler: _profileMenusHandler, transitionType: TransitionType.fadeIn);
//     router.define(myOrder, handler: _myOrderHandler, transitionType: TransitionType.fadeIn);
//     router.define(address, handler: _addressHandler, transitionType: TransitionType.fadeIn);
//     router.define(coupon, handler: _couponHandler, transitionType: TransitionType.fadeIn);
//     router.define(chatScreen, handler: _chatHandler, transitionType: TransitionType.fadeIn);
//     router.define(settings, handler: _settingsHandler, transitionType: TransitionType.fadeIn);
//     router.define(termsScreen, handler: _termsHandler, transitionType: TransitionType.fadeIn);
//     router.define(policyScreen, handler: _policyHandler, transitionType: TransitionType.fadeIn);
//     router.define(aboutUsScreen, handler: _aboutUsHandler, transitionType: TransitionType.fadeIn);
//     router.define(faqScreen, handler: _faqHandler, transitionType: TransitionType.fadeIn);
//     router.define(homeItem, handler: _homeItemHandler, transitionType: TransitionType.fadeIn);
//     router.define(maintenance, handler: _maintenanceHandler, transitionType: TransitionType.fadeIn);
//     router.define(contactScreen, handler: _contactHandler, transitionType: TransitionType.fadeIn);
//     router.define(update, handler: _updateHandler, transitionType: TransitionType.fadeIn);
//     router.define(addAddressScreen, handler: _newAddressHandler, transitionType: TransitionType.fadeIn);
//     router.define(favorite, handler: _favoriteHandler, transitionType: TransitionType.fadeIn);
//     router.define(wallet, handler: _walletHandler, transitionType: TransitionType.fadeIn);
//     router.define(referAndEarn, handler: _referAndEarnHandler, transitionType: TransitionType.material);
//     router.define(returnPolicyScreen, handler: _returnPolicyHandler, transitionType: TransitionType.fadeIn);
//     router.define(refundPolicyScreen, handler: _refundPolicyHandler, transitionType: TransitionType.fadeIn);
//     router.define(cancellationPolicyScreen, handler: _cancellationPolicyHandler, transitionType: TransitionType.fadeIn);
//     router.define(orderSearchScreen, handler: _orderSearchHandler, transitionType: TransitionType.fadeIn);
//     router.define(loyaltyScreen, handler: _loyaltyHandler, transitionType: TransitionType.fadeIn);
//     router.notFoundHandler = _notFoundHandler;
//   }
//
//   static  Widget _routeHandler({required Widget child}) {
//     return Provider.of<SplashProvider>(Get.context!, listen: false).configModel!.maintenanceMode!
//         ? const MaintenanceScreen() :   child ;
//
//   }
// }