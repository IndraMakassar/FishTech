import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const Header({Key? key, required this.title, this.showBackButton = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Evenly space items
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title == "Dashboard")
          _iconButton(Icons.menu, context)
          else if (showBackButton)
            _backButton(context)
          else
            const SizedBox(width: 44),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20,
            ),
          ),
          if (title == "Dashboard")
          _iconButton(Icons.notifications, context)
          else
          const SizedBox(width: 44),
        ],
      ),
    );
  }
  Widget _iconButton(IconData icon, BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
