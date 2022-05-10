import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String message;

  const EmptyScreen({
    Key? key,
    this.message = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/empty-state.png"),
            SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
