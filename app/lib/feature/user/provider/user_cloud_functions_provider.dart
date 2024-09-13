import 'package:scalable_flutter_app_pro/core/firebase/cloud_functions_provider.dart';
import 'package:scalable_flutter_app_pro/core/firebase/cloud_functions_response.dart';

class UserCloudFunctionsProvider extends CloudFunctionsProvider {
  Future<bool> setUserPhoto({
    required String imageUrl,
  }) {
    return call(CloudFunctions.setUserPhoto, {
      'imageUrl': imageUrl,
    }).toSuccessBool();
  }

  Future<bool> addUserFcmToken({
    required String token,
  }) {
    return call(CloudFunctions.addUserFcmToken, {
      'token': token,
    }).toSuccessBool();
  }

  Future<bool> removeUserFcmToken({
    required String token,
  }) {
    return call(CloudFunctions.removeUserFcmToken, {
      'token': token,
    }).toSuccessBool();
  }

  Future<bool> sendUserNotification() {
    return call(CloudFunctions.sendUserNotification).toSuccessBool();
  }
}
