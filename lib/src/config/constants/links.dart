import 'dart:io';
import 'package:myapp/src/config/devices/app_info.dart';

class XLink {
  static get playStore => 'market://details?id=${AppInfo.package.packageName}';
  static const appStore = 'https://apps.apple.com/app/idTODO';
  static get storeOf => Platform.isAndroid ? playStore : appStore;
}
