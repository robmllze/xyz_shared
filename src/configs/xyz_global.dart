import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

const kDeveloperMode = bool.fromEnvironment("developer", defaultValue: false);
const kEmulatorMode = bool.fromEnvironment("emulator", defaultValue: false);
const kAssetsPath = kIsWeb ? "" : "web/assets/";

abstract class XyzGlobal {
  final FirebaseApp firebaseApp;
  const XyzGlobal(this.firebaseApp);
}

// EXAMPLE EXAMPLE EXAMPLE:

//late final GlobalExample G;

class GlobalExample extends XyzGlobal {
  //
  //
  //

  const GlobalExample._(FirebaseApp firebaseApp) : super(firebaseApp);

  //
  //
  //

  static Future<GlobalExample> initialize() async {
    const kName = "xyz_app";
    const kOptions = FirebaseOptions(
      apiKey: "",
      appId: "",
      messagingSenderId: "",
      projectId: "",
    );
    final firebaseApp = await Firebase.initializeApp(
      name: kName,
      options: kOptions,
    );
    return GlobalExample._(firebaseApp);
  }
}
