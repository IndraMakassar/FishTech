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
          (title == "Dashboard")
              ? CustomIconbutton(
            icon: Icons.person,
            onTap: () {
              GoRouter.of(context).push('/profile');
            },
          )
              : (showBackButton
              ? CustomIconbutton(
            icon: Icons.arrow_back,
            onTap: () {
              Navigator.of(context).pop();
            },
          )
              : const SizedBox(width: 44)),
          Stack(
              clipBehavior: Clip.none, // penting! biar Positioned bebas keluar Container
              children: [
                Align(
                  alignment: Alignment.center, // atau Alignment.centerLeft kalau mau rata kiri
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
                    ),
                  ),
                ),
                Positioned(
                  top: -20,  // bebas geser
                  right: -32,
                  child: Image.asset(
                    'assets/whiteLogo.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          (title == "Dashboard")
              ? CustomIconbutton(
            icon: Icons.notifications,
            onTap: () {
              GoRouter.of(context).push('/notification');
            },
          )
              : (title == "Fish Pond Detail")
              ? CustomIconbutton(
            icon: Icons.settings,
            onTap: () {
              GoRouter.of(context).push('/settings');
            },
          )
              : const SizedBox(width: 44),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
