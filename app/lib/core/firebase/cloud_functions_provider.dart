import 'package:cloud_functions/cloud_functions.dart';
import 'package:scalable_flutter_app_pro/core/firebase/cloud_functions_response.dart';
import 'package:scalable_flutter_app_pro/core/logger/loggy_types.dart';

abstract class CloudFunctions {
  // User
  static const setUserPhoto = 'setUserPhoto';
  static const addUserFcmToken = 'addUserFcmToken';
  static const removeUserFcmToken = 'removeUserFcmToken';
  static const sendUserNotification = 'sendUserNotification';

  // Article
  static const articleAdd = 'articleAdd';

  // Feedback
  static const sendFeedback = 'sendFeedback';
}

abstract class CloudFunctionsProvider with ProviderLoggy {
  final _cloudFunctions = FirebaseFunctions.instanceFor(
    region: 'europe-west1',
  );

  Future<T?> callRaw<T>(
    String functionName, [
    Map<String, dynamic>? data,
  ]) async {
    try {
      final callable = _cloudFunctions.httpsCallable(functionName);
      final result = await callable.call<T>(data);
      return result.data;
    } catch (e, stack) {
      loggy.error('Cloud function raw [$functionName] error: $e', e, stack);
      return null;
    }
  }

  Future<CloudFunctionsResponse> call(
    String functionName, [
    Map<String, dynamic>? data,
  ]) async {
    try {
      final callable = _cloudFunctions.httpsCallable(functionName);
      final result = await callable.call<Map<String, dynamic>>(data);
      final response = CloudFunctionsResponse.fromJson(
        functionName,
        result.data,
      );

      if (response is CloudFunctionsResponseFailure) {
        loggy.error('Cloud function [$functionName] error: ${response.error}');
      }

      return response;
    } catch (e, stack) {
      loggy.error('Cloud function [$functionName] error: $e', e, stack);
      return CloudFunctionsResponseFailure.internalError(
        functionName: functionName,
      );
    }
  }
}
