import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:majootestcase/utils/app_colors.dart';

enum SnackBarType { success, error }

class AppSnackbar {
  static Future<void> show(
    BuildContext context, {
    required SnackBarType type,
    required String text,
    double? offset,
    Duration? duration,
    ToastGravity? gravity,
  }) async {
    final FToast fToast = FToast();
    fToast.init(context);

    final Map<SnackBarType, Color> bgColor = {
      SnackBarType.success: AppColors.jungle_light,
      SnackBarType.error: AppColors.burnt_sienna_light,
    };

    final Map<SnackBarType, Widget> icon = {
      SnackBarType.success: Icon(Icons.check_circle_outline, size: 20, color: AppColors.jungle),
      SnackBarType.error: Icon(Icons.cancel_outlined, size: 20, color: AppColors.burnt_sienna),
    };

    final Map<SnackBarType, Color> primaryColor = {
      SnackBarType.success: AppColors.jungle,
      SnackBarType.error: AppColors.burnt_sienna,
    };

    final Widget toast = SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: bgColor[type],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Row(children: [
              icon[type]!,
              SizedBox(width: 8),
              Expanded(child: Text(text, style: TextStyle(color: primaryColor[type]))),
              SizedBox(width: 2),
            ]),
          ),
          InkWell(
            onTap: () => fToast.removeCustomToast(),
            child: Icon(Icons.close, size: 20, color: primaryColor[type]),
          )
        ]),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: gravity ?? ToastGravity.TOP,
      toastDuration: duration ?? Duration(seconds: 3),
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: gravity == ToastGravity.TOP ? (offset ?? 0) : null,
          bottom: gravity == ToastGravity.BOTTOM ? (offset ?? 0) : null,
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
          child: child,
        );
      },
    );
  }
}
