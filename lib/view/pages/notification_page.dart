part of 'pages.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Notifications> notifications = [
    Notifications(
      pondName: "Pond 1",
      description: "Pond maintenance scheduled.",
      dateTime: "2.30 pm",
      status: 'unread',
    ),
    Notifications(
      pondName: "Pond 2",
      description: "Caution! Kolam Ikan Nila 1 pH is below the normal average for a long time",
      dateTime: "2.30 pm",
      status: 'unread',
    ),
    // Tambahkan lebih banyak data jika diperlukan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Notifications', showBackButton: true),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state){
          if (state is AuthAuthenticated) {
            GoRouter.of(context).go('/notification');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state){
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notifications.length,
            itemBuilder: (context, index){
              final notif = notifications[index];
              return NotificationCard(
                pondName: notif.pondName,
                description: notif.description,
                dateTime: notif.dateTime,
                status: notif.status,
                onTap: () async{
                  setState(() {
                    notifications[index] = Notifications(
                        pondName: notif.pondName,
                        description: notif.description,
                        dateTime: notif.dateTime,
                        status: 'read',
                    );
                  });
                  GoRouter.of(context).push('/${notif.pondName}');
                },
              );
            },
          );
        },
      )

    );
  }
}
