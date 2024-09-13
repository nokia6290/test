import 'package:scalable_flutter_app_pro/core/firebase/cloud_functions_provider.dart';
import 'package:scalable_flutter_app_pro/core/firebase/cloud_functions_response.dart';

class ArticleCloudFunctionsProvider extends CloudFunctionsProvider {
  Future<bool> articleAdd({
    required String title,
    required String subtitle,
    required String text,
  }) {
    return call(CloudFunctions.articleAdd, {
      'title': title,
      'subtitle': subtitle,
      'text': text,
    }).toSuccessBool();
  }
}
