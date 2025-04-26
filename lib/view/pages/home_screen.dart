part of 'pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> statisticData =[

  ];
  final List<Map<String, dynamic>> fishPondData = [
    {
      'name': 'Kolam Ikan Nila 1',
      'machineCount': 1,
      'feedAmount': 3,
      'pH': 7,
      'temperature': 27.0,
      'condition' : 'Good',
    },
    {
      'name': 'Kolam Ikan Lele',
      'machineCount': 2,
      'feedAmount': 5,
      'pH': 6.5,
      'temperature': 28.0,
      'condition' : 'Warning',
    },
    {
      'name': 'Kolam Ikan Gurame',
      'machineCount': 1,
      'feedAmount': 4,
      'pH': 7.2,
      'temperature': 26.0,
      'condition' : 'Danger',
    },
    {
      'name': 'Kolam Ikan Patin',
      'machineCount': 3,
      'feedAmount': 6,
      'pH': 6.8,
      'temperature': 29.0,
      'condition' : 'Warning',
    },
    {
      'name': 'Kolam Ikan Patin',
      'machineCount': 3,
      'feedAmount': 6,
      'pH': 6.8,
      'temperature': 29.0,
      'condition' : 'Good',
    },
    {
      'name': 'Kolam Ikan Patin',
      'machineCount': 3,
      'feedAmount': 6,
      'pH': 6.8,
      'temperature': 29.0,
      'condition' : 'Good',
    },
  ];
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: "Dashboard"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeCard(
              name: 'John Doe',
              total: fishPondData.where((pond) => pond['condition'] == 'Warning' || pond['condition'] == 'Danger').length,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                      'Fish Pond',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const Gap(10),
                  if(fishPondData.isEmpty)
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Center(
                          child: Text(
                            'No Fish Pond data available. Click "+" to Add',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
                            ),
                          )
                      ),
                    )
                  else
                    SizedBox(
                    height: 400, // Atur tinggi card area
                    child: PageView(
                      controller: _pageController,
                      children: _buildPages(),
                    ),
                  ),
                  const Gap(10),
                  if(fishPondData.isEmpty)
                    const Gap(0)
                  else
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: (fishPondData.length / 4).ceil(),
                      effect: WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Statistics',
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          GoRouter.of(context).push('/statistics');
                        },
                        child: Text(
                          'see all',
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    ],
                  ),
                  //TODO: tambah widgetStatistik
                  if(statisticData.isEmpty)
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Center(
                          child: Text(
                            'No Statistics data available yet.',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
                            ),
                          )
                      ),
                    )
                  else
                    const Gap(0),

                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push('/addPond');
        },
        backgroundColor: Theme.of(context).colorScheme.primary, // Match the app's theme color
        child: const Icon(Icons.add, color: Colors.white), // FAB icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: SafeArea(
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 250,
            height: 500,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    height: 70,
                    color: Theme.of(context).colorScheme.primary,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      GoRouter.of(context).push('/profile');
                    },
                    child: Material(
                      elevation: 2,
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/Logo.png",
                              height: 90,
                              width: 90,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'John Doe',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  Text(
                                    'johndoe@gmail.com',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  Text(
                                    '0892-4252-2254',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomDrawerTile(
                    icon: Icons.home_rounded,
                    title: 'Home',
                    selected: _selectedIndex == 0,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  CustomDrawerTile(
                    icon: Icons.notifications, // Contoh ganti icon
                    title: 'Notification',
                    selected: _selectedIndex == 1,
                    onTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).push('/notification');
                    },
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  CustomDrawerTile(
                    icon: Icons.bar_chart, // Contoh ganti icon
                    title: 'Statistics',
                    selected: _selectedIndex == 2,
                    onTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).push('/statistic');
                    },
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  CustomDrawerTile(
                    icon: Icons.logout_rounded, // Contoh ganti icon
                    title: 'Logout',
                    selected: _selectedIndex == 2,
                    onTap: () {
                      _onItemTapped(2);
                      Navigator.pop(context);
                    },
                    color: Theme.of(context).colorScheme.error,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  List<Widget> _buildPages() {
    List<Widget> pages = [];
    int totalPages = (fishPondData.length / 4).ceil();

    for (int i = 0; i < totalPages; i++) {
      final start = i * 4;
      final end = (start + 4) > fishPondData.length ? fishPondData.length : start + 4;
      final ponds = fishPondData.sublist(start, end);

      pages.add(
        MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          itemCount: ponds.length,
          physics: const NeverScrollableScrollPhysics(), // Disable scroll di grid
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final pond = ponds[index];
            return FishPondCard(
              name: pond['name'],
              machineCount: pond['machineCount'],
              feedAmount: pond['feedAmount'].toDouble(),
              pH: pond['pH'].toDouble(),
              temperature: pond['temperature'].toDouble(),
              condition: pond['condition'],
            );
          },
        ),
      );
    }
    return pages;
  }

}
