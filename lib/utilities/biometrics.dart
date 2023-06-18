import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AppBiometrics {
  static LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> checkIfAvailable() async {
    // You can also access _localAuthentication here
    return await _localAuthentication.canCheckBiometrics;
  }

  Future<bool> authenticate() async {
    try {
      if (await checkIfAvailable()) {
        return _localAuthentication.authenticate(
            options: const AuthenticationOptions(
                useErrorDialogs: true, stickyAuth: true),
            localizedReason:
                "needs to authenticate before showing account balance and account information");
      }
    } on PlatformException catch (e) {
      log(e.toString());
    }
    return false;
  }
}
