part of 'widgets.dart';

class DataPondWidget extends StatelessWidget {
  final Widget icon;
  final String value;
  final String label;

  const DataPondWidget({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const Gap(5),
            icon,
          ],
        ),
        const Gap(4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            overflow: TextOverflow.ellipsis
          ),
        ),
      ],
    );
  }
}
