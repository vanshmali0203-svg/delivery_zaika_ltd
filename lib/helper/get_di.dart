import 'package:get/get.dart';
import 'export.dart';

Future<Map<String, Map<String, String>>> init() async {
  /// Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  ///Repository Interface
  AuthRepositoryInterface authRepositoryInterface =
      AuthRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => authRepositoryInterface);
  ProfileRepositoryInterface profileRepositoryInterface =
      ProfileRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => profileRepositoryInterface);

  ChatRepositoryInterface chatRepositoryInterface =
      ChatRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => chatRepositoryInterface);

  SplashRepositoryInterface splashRepositoryInterface =
      SplashRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => splashRepositoryInterface);

  NotificationRepositoryInterface notificationRepositoryInterface =
      NotificationRepository(
          apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => notificationRepositoryInterface);

  DisbursementRepositoryInterface disbursementRepositoryInterface =
      DisbursementRepository(
          apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => disbursementRepositoryInterface);

  LanguageRepositoryInterface languageRepositoryInterface =
      LanguageRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => languageRepositoryInterface);

  OrderRepositoryInterface orderRepositoryInterface =
      OrderRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => orderRepositoryInterface);

  ForgotPasswordRepositoryInterface forgotPasswordRepositoryInterface =
      ForgotPasswordRepository(
          apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => forgotPasswordRepositoryInterface);

  CashInHandRepositoryInterface cashInHandRepositoryInterface =
      CashInHandRepository(
          apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => cashInHandRepositoryInterface);

  AddressRepositoryInterface addressRepositoryInterface =
      AddressRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => addressRepositoryInterface);

  ///Service Interface
  AuthServiceInterface authServiceInterface =
      AuthService(authRepositoryInterface: Get.find());
  Get.lazyPut(() => authServiceInterface);

  ProfileServiceInterface profileServiceInterface =
      ProfileService(profileRepositoryInterface: Get.find());
  Get.lazyPut(() => profileServiceInterface);

  ChatServiceInterface chatServiceInterface =
      ChatService(chatRepositoryInterface: Get.find());
  Get.lazyPut(() => chatServiceInterface);

  SplashServiceInterface splashServiceInterface =
      SplashService(splashRepositoryInterface: Get.find());
  Get.lazyPut(() => splashServiceInterface);

  NotificationServiceInterface notificationServiceInterface =
      NotificationService(notificationRepositoryInterface: Get.find());
  Get.lazyPut(() => notificationServiceInterface);

  DisbursementServiceInterface disbursementServiceInterface =
      DisbursementService(disbursementRepositoryInterface: Get.find());
  Get.lazyPut(() => disbursementServiceInterface);

  LanguageServiceInterface languageServiceInterface =
      LanguageService(languageRepositoryInterface: Get.find());
  Get.lazyPut(() => languageServiceInterface);

  OrderServiceInterface orderServiceInterface =
      OrderService(orderRepositoryInterface: Get.find());
  Get.lazyPut(() => orderServiceInterface);

  ForgotPasswordServiceInterface forgotPasswordServiceInterface =
      ForgotPasswordService(forgotPasswordRepositoryInterface: Get.find());
  Get.lazyPut(() => forgotPasswordServiceInterface);

  CashInHandServiceInterface cashInHandServiceInterface =
      CashInHandService(cashInHandRepositoryInterface: Get.find());
  Get.lazyPut(() => cashInHandServiceInterface);

  AddressServiceInterface addressServiceInterface =
      AddressService(addressRepositoryInterface: Get.find());
  Get.lazyPut(() => addressServiceInterface);

  ///Services
  Get.lazyPut(() => AuthService(authRepositoryInterface: Get.find()));
  Get.lazyPut(() => ProfileService(profileRepositoryInterface: Get.find()));
  Get.lazyPut(() => ChatService(chatRepositoryInterface: Get.find()));
  Get.lazyPut(() => SplashService(splashRepositoryInterface: Get.find()));
  Get.lazyPut(
      () => NotificationService(notificationRepositoryInterface: Get.find()));
  Get.lazyPut(
      () => DisbursementService(disbursementRepositoryInterface: Get.find()));
  Get.lazyPut(() => LanguageService(languageRepositoryInterface: Get.find()));
  Get.lazyPut(() => OrderService(orderRepositoryInterface: Get.find()));
  Get.lazyPut(() =>
      ForgotPasswordService(forgotPasswordRepositoryInterface: Get.find()));
  Get.lazyPut(
      () => CashInHandService(cashInHandRepositoryInterface: Get.find()));
  Get.lazyPut(() => AddressService(addressRepositoryInterface: Get.find()));

  ///Controller
  Get.lazyPut(() => AuthController(authServiceInterface: Get.find()));
  Get.lazyPut(() => ProfileController(profileServiceInterface: Get.find()));
  Get.lazyPut(() => ChatController(chatServiceInterface: Get.find()));
  Get.lazyPut(() => SplashController(splashServiceInterface: Get.find()));
  Get.lazyPut(
      () => NotificationController(notificationServiceInterface: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => DisbursementController(disbursementServiceInterface: Get.find()));
  Get.lazyPut(
      () => LocalizationController(languageServiceInterface: Get.find()));
  Get.lazyPut(() => OrderController(orderServiceInterface: Get.find()));
  Get.lazyPut(() =>
      ForgotPasswordController(forgotPasswordServiceInterface: Get.find()));
  Get.lazyPut(
      () => CashInHandController(cashInHandServiceInterface: Get.find()));
  Get.lazyPut(() => AddressController(addressServiceInterface: Get.find()));

  /// Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
