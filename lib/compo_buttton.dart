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
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          },
          child: Text(label),
        ),
        const Divider(),
      ],
    );
  }
}
