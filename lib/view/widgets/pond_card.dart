part of 'widgets.dart';

class FishPondCard extends StatelessWidget {
  final PondCardModel pondModel;

  const FishPondCard({super.key, required this.pondModel});

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
                    pondModel.name,
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
                  color: _getConditionColor(context, pondModel.condition),
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
                  value: pondModel.machineCount.toString(),
                  label: 'Machine',
                ),
                DataPondWidget(
                  icon: const Icon(Icons.scale),
                  value: pondModel.feedAmount.toStringAsFixed(1),
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
                  value: pondModel.pH.toStringAsFixed(2),
                  label: 'Ph',
                ),
                DataPondWidget(
                  icon: const Icon(Icons.thermostat),
                  value: '${pondModel.temperature.toStringAsFixed(1)}°',
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
