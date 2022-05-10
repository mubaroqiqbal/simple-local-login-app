import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double height;

  const LoadingIndicator({Key? key, this.height = 10}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(strokeWidth: 100),
      ),
    );
  }
}
