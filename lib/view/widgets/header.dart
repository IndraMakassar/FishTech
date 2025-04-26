part of 'widgets.dart';

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
            CustomIconbutton(icon: Icons.menu, onTap: (){Scaffold.of(context).openDrawer();})
          else if (showBackButton)
            CustomIconbutton(icon: Icons.arrow_back, onTap: (){Navigator.of(context).pop();},)
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
          CustomIconbutton(icon: Icons.notifications, onTap: (){GoRouter.of(context).push('/notification');},)
          else
          const SizedBox(width: 44),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
