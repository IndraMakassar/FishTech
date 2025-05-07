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
            CustomIconbutton(icon: Icons.menu, onTap: (){Scaffold.of(context).openDrawer();}),
          if (title == "Fish Pond Detail")
          _backButton(context)
          else if (showBackButton)
            CustomIconbutton(icon: Icons.arrow_back, onTap: (){Navigator.of(context).pop();},)
          else
            const SizedBox(width: 44),
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



          if (title == "Dashboard")
          CustomIconbutton(icon: Icons.notifications, onTap: (){GoRouter.of(context).push('/notification');},)
          else if (title == "Fish Pond Detail")
          _iconButton(Icons.settings, context, path: '/settings')
          else
          const SizedBox(width: 44),
        ],
      ),
    );
  }
  Widget _iconButton(IconData icon, BuildContext context, {String? path}) {
    return InkWell(
      onTap: (){
        GoRouter.of(context).push(path!);
      },
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
            icon,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
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
