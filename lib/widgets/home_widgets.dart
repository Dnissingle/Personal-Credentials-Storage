import 'package:flutter/material.dart';


class HomeWidgets extends StatelessWidget {
  final IconData icon;
  final String text;
  const HomeWidgets({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber
          ),
          child: Center(
            child: Icon(icon, color: Colors.black,
            size: 40),
          ),
        ),
        const SizedBox(height: 8,),
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
