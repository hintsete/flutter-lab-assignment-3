import 'package:flutter/material.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorDisplayWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: TextStyle(color: Colors.red)),
          SizedBox(height: 8),
          ElevatedButton(onPressed: onRetry, child: Text('Retry')),
        ],
      ),
    );
  }
}