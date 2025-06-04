part of 'pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> statisticData = [];
  final PageController _pageController = PageController();

  Future<void> _updateFcmTokenIfLoggedIn() async {
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      try {
        final token = await FirebaseMessaging.instance.getToken();
        if (token != null && token.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          final oldToken = prefs.getString('fcm_token');

          if (oldToken != token) {
            context.read<AuthBloc>().add(UserChangeToken(newToken: token));
            await prefs.setString('fcm_token', token);
            debugPrint('FCM Token updated: $token');
          } else {
            debugPrint('FCM Token unchanged.');
          }
        }
      } catch (e, stackTrace) {
        debugPrint('Error getting/updating FCM token: $e');
        debugPrint('Stack trace: $stackTrace');
      }
    }
  }

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
  void initState() {
    super.initState();
    _updateFcmTokenIfLoggedIn();
    context.read<PondBloc>().add(const FetchPond());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: "Dashboard"),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                if (authState is AuthAuthenticated ||
                    authState is AuthLoadingWhileAuthenticated) {
                  return BlocBuilder<PondBloc, PondState>(
                    builder: (context, pondState) {
                      int warningCount = 0;
                      if (pondState is PondSuccess) {
                        warningCount = pondState.ponds
                            .where((p) =>
                        p.condition == 'Warning' ||
                            p.condition == 'Danger')
                            .length;
                      }

                      final session = authState is AuthAuthenticated
                          ? authState.session
                          : (authState as AuthLoadingWhileAuthenticated).session;


                      final userName = session.user.userMetadata?['name'] ?? // Google login name
                          session.user.userMetadata?['Display name'] ?? // Email login display name
                          'User';

                      return WelcomeCard(
                        name: userName,
                        total: warningCount,
                      );
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
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
                        fontWeight: FontWeight.bold),
                  ),
                  const Gap(10),
                  BlocBuilder<PondBloc, PondState>(
                    builder: (context, state) {
                      if (state is PondLoading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }

                      if (state is PondFailure) {
                        return Center(child: Text("Error: ${state.message}"));
                      }

                      final ponds = (state is PondSuccess)
                          ? state.ponds
                          : <PondCardModel>[];

                      if (ponds.isEmpty) {
                        return SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                GoRouter.of(context).push('/addPond');
                              },
                              child: Text(
                                'No Fish Pond data available. Click to Add',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: PageView(
                                controller: _pageController,
                                children: _buildPages(ponds),
                              ),
                            ),
                            const Gap(10),
                            Center(
                              child: SmoothPageIndicator(
                                controller: _pageController,
                                count: (ponds.length / 4).ceil(),
                                effect: WormEffect(
                                  dotHeight: 10,
                                  dotWidth: 10,
                                  activeDotColor:
                                  Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    },
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
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push('/statistics');
                        },
                        child: Text(
                          'see all',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      )
                    ],
                  ),
                  //TODO: tambah widgetStatistik
                  if (statisticData.isEmpty)
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Center(
                          child: Text(
                            'No Statistics data available yet.',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant),
                          )),
                    )
                  else
                    const Gap(0),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push('/addPond');
        },
        backgroundColor: Theme.of(context)
            .colorScheme
            .primary, // Match the app's theme color
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ), // FAB icon
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 30),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).push('/profile');
                    },
                    child: Material(
                      elevation: 2,
                      color:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    'johndoe@gmail.com',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                                  ),
                                  Text(
                                    '0892-4252-2254',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
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
                    icon: Icons.notifications,
                    // Contoh ganti icon
                    title: 'Notification',
                    selected: _selectedIndex == 1,
                    onTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).push('/notification');
                    },
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  CustomDrawerTile(
                    icon: Icons.bar_chart,
                    // Contoh ganti icon
                    title: 'Statistics',
                    selected: _selectedIndex == 2,
                    onTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).push('/statistic');
                    },
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  CustomDrawerTile(
                    icon: Icons.logout_rounded,
                    // Contoh ganti icon
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

  List<Widget> _buildPages(List<PondCardModel> ponds) {
    final pages = <Widget>[];
    final chunkCount = (ponds.length / 4).ceil();

    for (var page = 0; page < chunkCount; page++) {
      final start = page * 4;
      final end = (start + 4) > ponds.length ? ponds.length : start + 4;
      final slice = ponds.sublist(start, end);

      pages.add(
        MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          itemCount: slice.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (ctx, i) {
            final pond = slice[i];
            return GestureDetector(
              onTap: () {
                GoRouter.of(context).push(
                  '/details',
                  extra: pond,
                );
              },
              child: FishPondCard(pondModel: pond),
            );
          },
        ),
      );
    }

    return pages;
  }
}