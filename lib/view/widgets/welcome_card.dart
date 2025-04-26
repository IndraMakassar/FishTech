import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WelcomeCard extends StatelessWidget {
  final String name;
  final int total;
  const WelcomeCard({
    super.key,
    required this.name,
    required this.total
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Theme.of(context).colorScheme.primaryContainer,
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
                   RichText(
                     overflow: TextOverflow.ellipsis,
                     text: TextSpan(
                       style: TextStyle(
                         fontSize: 18,
                         color: Theme.of(context).colorScheme.onPrimaryContainer,
                         fontWeight: FontWeight.bold,
                       ),
                       children: [
                         const TextSpan(text: 'Welcome, '),
                         TextSpan(
                           text: name,
                           style: TextStyle(
                             color: Theme.of(context).colorScheme.primary,
                           ),
                         ),
                       ],
                     ),
                   ),
                   const Gap(5),
                   RichText(
                     overflow: TextOverflow.ellipsis,
                     text: TextSpan(
                       style: TextStyle(
                         fontSize: 12,
                         color: Theme.of(context).colorScheme.onPrimaryContainer,
                       ),
                       children: [
                         const TextSpan(text: 'You Have '),
                         TextSpan(
                           text: '$total Fish Pond',
                           style: TextStyle(
                             color: Theme.of(context).colorScheme.primary,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         const TextSpan(text: ' to Check now!'),
                       ],
                     ),
                   ),
                 ],
               ),
             )
           ],
        ),
      ),
    );
  }
}
