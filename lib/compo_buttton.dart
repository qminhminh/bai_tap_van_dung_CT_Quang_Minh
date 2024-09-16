// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ExerciseButton extends StatelessWidget {
  final String label;
  final Widget destination;

  const ExerciseButton({
    required this.label,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent, // Màu văn bản của nút
          padding: const EdgeInsets.symmetric(
              vertical: 16.0, horizontal: 24.0), // Khoảng cách bên trong nút
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12.0), // Bo tròn các góc của nút
          ),
          elevation: 5, // Độ cao bóng đổ của nút
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18, // Kích thước chữ
            fontWeight: FontWeight.bold, // Độ đậm của chữ
          ),
        ),
      ),
    );
  }
}
