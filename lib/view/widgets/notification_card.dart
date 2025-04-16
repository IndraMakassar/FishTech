import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NotificationCard extends StatefulWidget {
  final String pondName;
  final String description;
  final String dateTime;
  final String status;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.pondName,
    required this.description,
    required this.dateTime,
    required this.onTap,
    this.status = 'unread'
  });

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        elevation: 4,
        shadowColor: Theme.of(context).shadowColor,
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pondName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                              Icons.warning_rounded,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const Gap(5),
                          Expanded(
                            child: Text(
                              widget.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                                fontSize: 11,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Gap(5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      widget.dateTime,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const Gap(5),
                  if (widget.status == 'unread')
                    Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:  Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              )
            ],
          ),

        ),
      ),
    );
  }
}
