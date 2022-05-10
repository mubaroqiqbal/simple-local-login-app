import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final Function()? retry;
  final Color? textColor;
  final double fontSize;
  final Widget? retryButton;
  final Widget? icon;

  const ErrorScreen({
    Key? key,
    this.retryButton,
    this.message = "",
    this.fontSize = 14,
    this.retry,
    this.icon,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Column(children: [
                icon!,
                SizedBox(height: 16),
              ]),
            Text(message, style: TextStyle(fontSize: fontSize, color: textColor ?? Colors.black)),
            retry != null
                ? Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      retryButton ??
                          IconButton(
                            onPressed: () {
                              if (retry != null) retry!();
                            },
                            icon: Icon(Icons.refresh_sharp),
                          ),
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
