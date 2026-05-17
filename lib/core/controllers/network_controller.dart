import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  var isConnected = true.obs;

  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void onInit() {
    super.onInit();
    _subscription =
        Connectivity().onConnectivityChanged.listen(_onConnectivityChanged);
    _refreshConnection();
  }

  Future<void> _refreshConnection() async {
    final result = await Connectivity().checkConnectivity();
    await _onConnectivityChanged(result);
  }

  Future<void> _onConnectivityChanged(List<ConnectivityResult> result) async {
    if (result.isEmpty) {
      // Some platforms briefly return [] before a real value — don't mark offline.
      return;
    }

    final hasNetworkInterface = !result.contains(ConnectivityResult.none);

    if (hasNetworkInterface) {
      isConnected.value = true;
      return;
    }

    // Plugin says offline — confirm with a quick lookup (fixes simulator false negatives).
    isConnected.value = await _hasReachableInternet();
  }

  /// connectivity_plus only checks Wi‑Fi/mobile radio, not real internet.
  static Future<bool> _hasReachableInternet() async {
    try {
      final addresses = await InternetAddress.lookup('one.one.one.one')
          .timeout(const Duration(seconds: 3));
      return addresses.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}