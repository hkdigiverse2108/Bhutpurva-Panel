import 'package:flutter/material.dart';

class AppTableEmpty extends StatelessWidget {
  final String message;
  final VoidCallback? onAdd;

  const AppTableEmpty({super.key, required this.message, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 40, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(message, style: TextStyle(color: Colors.grey.shade600)),
          if (onAdd != null) ...[
            const SizedBox(height: 12),
            ElevatedButton(onPressed: onAdd, child: const Text("Add New")),
          ],
        ],
      ),
    );
  }
}
