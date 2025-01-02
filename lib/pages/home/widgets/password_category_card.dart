import 'package:flutter/material.dart';

class PasswordCategoryCard extends StatelessWidget {
  final Function() onClick;
  final String title;
  final Color color;
  final Widget icon;

  const PasswordCategoryCard(
      {super.key,
      required this.onClick,
      required this.title,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      height: 140,
      width: 112,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(
            title,
            textAlign: TextAlign.center,
            softWrap: true,
          )
        ],
      ),
    );
  }
}
