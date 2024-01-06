import 'package:flutter/material.dart';

class XBottomSheet {
  static Future<T?> showCustomBottomSheet<T>({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
    ShapeBorder? shape,
    Color? backgroundColor,
  }) async {
    return showModalBottomSheet<T>(
      shape: shape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
      backgroundColor: backgroundColor,
      context: context,
      builder: builder,
    );
  }
}
