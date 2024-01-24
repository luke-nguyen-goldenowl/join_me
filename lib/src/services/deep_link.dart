import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:myapp/src/router/coordinator.dart';
import 'package:uni_links/uni_links.dart';

class XDeepLinks {
  static String _promoId = '';
  static String get promoId => _promoId;
  static bool get hasPromoId => _promoId.isNotEmpty;

  static void reset() => _promoId = '';

  static Future<void> init({checkActualVersion = false}) async {
    // This is used for cases when: APP is not running and the user clicks on a link.
    try {
      final Uri? uri = await getInitialUri();
      _uniLinkHandler(uri: uri);
    } on PlatformException {
      if (kDebugMode) {
        print("(PlatformException) Failed to receive initial uri.");
      }
    } on FormatException catch (error) {
      if (kDebugMode) {
        print(
            "(FormatException) Malformed Initial URI received. Error: $error");
      }
    }

    // This is used for cases when: APP is already running and the user clicks on a link.
    uriLinkStream.listen((Uri? uri) async {
      _uniLinkHandler(uri: uri);
    }, onError: (error) {
      if (kDebugMode) print('UniLinks onUriLink error: $error');
    });
  }

  static Future<void> _uniLinkHandler({required Uri? uri}) async {
    if (uri == null || uri.queryParameters.isEmpty) return;
    Map<String, String> params = uri.queryParameters;

    String receivedPromoId = params['event-id'] ?? '';
    if (receivedPromoId.isEmpty) return;
    _promoId = receivedPromoId;

    if (hasPromoId) {
      AppCoordinator.showEventDetails(id: _promoId);
    }
  }
}
