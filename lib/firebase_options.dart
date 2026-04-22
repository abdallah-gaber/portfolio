// Placeholder config file.
// Run `dart run flutterfire_cli:flutterfire configure` to generate a real one
// for your local Firebase project before enabling analytics in production.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'YOUR_FIREBASE_API_KEY',
      authDomain: 'YOUR_FIREBASE_AUTH_DOMAIN',
      projectId: 'YOUR_FIREBASE_PROJECT_ID',
      storageBucket: 'YOUR_FIREBASE_STORAGE_BUCKET',
      messagingSenderId: 'YOUR_FIREBASE_MESSAGING_SENDER_ID',
      appId: 'YOUR_FIREBASE_APP_ID',
      measurementId: 'YOUR_FIREBASE_MEASUREMENT_ID',
    );
  }
}
