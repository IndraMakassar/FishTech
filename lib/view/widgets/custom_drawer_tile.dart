import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomDrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;
  final Color color;

  const CustomDrawerTile({
    super.key,
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: color,
          ),
          const Gap(10),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      selected: selected,
      onTap: onTap,
    );
  }
}
