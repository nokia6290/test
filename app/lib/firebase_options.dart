import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    throw UnimplementedError('''


Set up Firebase:

1. Create a new Firebase project (if you don't already have one)
2. Run `flutterfire configure` in the terminal
3. Select your Firebase project
4. Select platforms you want to support (Android, iOS, web)
5. If asked to update files, select `y` (yes)
''');
  }
}
