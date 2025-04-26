part of 'widgets.dart';

class FishPondCard extends StatelessWidget {
  final String name;
  final int machineCount;
  final double feedAmount;
  final double pH;
  final double temperature;
  final String condition;

  const FishPondCard({
    super.key,
    required this.name,
    required this.machineCount,
    required this.feedAmount,
    required this.pH,
    required this.temperature,
    required this.condition,
  });

  //TODO: ganti warna sesuai Theme kalau bisa
  Color _getConditionColor(BuildContext context, String condition) {
    switch (condition) {
      case 'Good':
        return Colors.green;
      case 'Warning':
        return Colors.orange;
      case 'Danger':
        return Theme.of(context).colorScheme.error;
      default:
        return Colors.grey;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const Gap(5),
                Icon(
                  Icons.circle,
                  color: _getConditionColor(context, condition),
                  size: 12,
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //TODO: Apakah Icon Perlu diubah?
                //TODO: Apakah Kata informasi perlu diubah?
                DataPondWidget(
                  icon: const Icon(Icons.precision_manufacturing),
                  value: '$machineCount',
                  label: 'Machine',
                ),
                DataPondWidget(
                  icon: const Icon(Icons.scale),
                  value: '$feedAmount',
                  label: 'Kg/day',
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DataPondWidget(
                  icon: const Icon(Icons.water_drop),
                  value: '$pH',
                  label: 'Ph',
                ),
                DataPondWidget(
                  icon: const Icon(Icons.thermostat),
                  value: '$temperature°',
                  label: 'Temperature',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
