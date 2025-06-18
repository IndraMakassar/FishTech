part of 'pages.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState(){
    super.initState();
    context.read<NotifBloc>().add(const FetchNotif());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Notifications', showBackButton: true),
      body: BlocBuilder<NotifBloc, NotifState>(
        builder: (context, state){
          if (state is NotifLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NotifFailure) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }
          if (state is NotifSuccess) {
            if (state.notif.isEmpty) {
              return const Center(
                child: Text('No notifications'),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.notif.length,
              itemBuilder: (context, index){
                final notif = state.notif[index];
                return NotificationCard(
                  pondName: notif.title,
                  description: notif.body,
                  dateTime: DateTimeFormatter.getRelativeTime(notif.createdAt),
                  status: notif.status,
                  onTap: () async {
                    // Dispatch event to update status in Supabase
                    context.read<NotifBloc>().add(
                      UpdateNotifStatus(
                        notifId: notif.id,
                        status: 'read',
                      ),
                    );
                    GoRouter.of(context).push('/${notif.title}');
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      )

    );
  }
}