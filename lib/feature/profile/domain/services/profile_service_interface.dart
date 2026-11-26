import '../../../../helper/export.dart';

abstract class ProfileServiceInterface {
  Future<dynamic> getProfileInfo();
  Future<dynamic> recordLocation(RecordLocationBody recordLocationBody);
  Future<dynamic> updateProfile(
      ProfileModel userInfoModel, XFile? data, String token);
  Future<dynamic> updateActiveStatus({int? shiftId});
  bool isNotificationActive();
  void setNotificationActive(bool isActive);
  Future<dynamic> deleteDriver();
  Future<dynamic> getShiftList();
  void checkPermission(Function callback);
  Future<String> addressPlaceMark(Position locationResult);
}
