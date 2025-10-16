import '../../../../helper/export.dart';

class SplashService implements SplashServiceInterface {
  final SplashRepositoryInterface splashRepositoryInterface;
  SplashService({required this.splashRepositoryInterface});

  @override
  Future<ConfigModel?> getConfigData() async {
    return await splashRepositoryInterface.getConfigData();
  }

  @override
  Future<bool> initSharedData() async {
    return await splashRepositoryInterface.initSharedData();
  }

  @override
  Future<bool> removeSharedData() async {
    return await splashRepositoryInterface.removeSharedData();
  }

  @override
  void setLanguageIntro(bool intro) {
    splashRepositoryInterface.setLanguageIntro(intro);
  }

  @override
  bool showLanguageIntro() {
    return splashRepositoryInterface.showLanguageIntro();
  }
}
