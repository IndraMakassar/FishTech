part of 'pages.dart';

class DetailKolam extends StatefulWidget {
  final PondCardModel pond;

  const DetailKolam({Key? key, required this.pond}) : super(key: key);

  @override
  _DetailKolamState createState() => _DetailKolamState();
}

class _DetailKolamState extends State<DetailKolam> {
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).push('/addPond');
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.add,
            color: colorScheme.onPrimary,
            size: 38,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: const Header(
          title: 'Fish Pond Detail',
          showBackButton: true,
        ),
        body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthAuthenticated) {
            GoRouter.of(context).go('/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceDim,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.pond.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            Switch(
                              value: isOn,
                              onChanged: (bool value) {
                                setState(() {
                                  isOn = value;
                                });
                              },
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.red,
                              activeTrackColor: Colors.green,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Fish Type",
                                  style: TextStyle(
                                    color: Color(0xFF43474E),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  widget.pond.fish ?? "",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  "Pord Size",
                                  style: TextStyle(
                                    color: Color(0xFF43474E),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${widget.pond.volume ?? 0}m3",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Date of Creation",
                                  style: TextStyle(
                                    color: Color(0xFF43474E),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd MMM yyyy')
                                      .format(widget.pond.createdAt),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Sensors",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 12,
                      ),
                      children: [
                        _buildInfoCard(
                          "pH ",
                          widget.pond.pH.toStringAsFixed(2),
                          Icons.opacity,
                        ),
                        _buildInfoCard(
                          "Temperature",
                          widget.pond.temperature.toStringAsFixed(1),
                          Icons.thermostat,
                        ),
                        _buildInfoCard(
                          "Food Used/day",
                          widget.pond.feedAmount.toStringAsFixed(1),
                          Icons.food_bank,
                        ),
                        _buildInfoCard(
                          "Last Autofeeder",
                          widget.pond.lastAutofeederOn != null
                              ? _getElapsedTime(widget.pond.lastAutofeederOn!)
                              : 'Unknown',
                          Icons.timer,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Statistics",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(0, 4))
                      ]),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Use of Fish Feed",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF43474e)),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 200,
                        child: BarChart(
                          BarChartData(
                            barGroups: _buildBarGroups(),
                            titlesData: FlTitlesData(
                              show: true,
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget:
                                      (double value, TitleMeta meta) {
                                    const style = TextStyle(
                                      color: Color(0xFF75729E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    );
                                    Widget text;
                                    switch (value.toInt()) {
                                      case 0:
                                        text = const Text('Mon', style: style);
                                        break;
                                      case 1:
                                        text = const Text('Tue', style: style);
                                        break;
                                      case 2:
                                        text = const Text('Wed', style: style);
                                        break;
                                      case 3:
                                        text = const Text('Thu', style: style);
                                        break;
                                      case 4:
                                        text = const Text('Fri', style: style);
                                        break;
                                      case 5:
                                        text = const Text('Sat', style: style);
                                        break;
                                      case 6:
                                        text = const Text('Sun', style: style);
                                        break;
                                      default:
                                        text = const Text('', style: style);
                                        break;
                                    }
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: text,
                                    );
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 5,
                                  getTitlesWidget:
                                      (double value, TitleMeta meta) {
                                    const style = TextStyle(
                                      color: Color(0xFF75729E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 8,
                                    );
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      space: 0,
                                      child: Text('${value.toInt()}kg',
                                          style: style),
                                    );
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            gridData: const FlGridData(show: false),
                            barTouchData: BarTouchData(enabled: false),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: Color(0xFF5CB1F5),
            //   onPressed: () {
            //   },
            //   child: Icon(Icons.add, color: Colors.white),
            // ),
            ));
  }

  List<BarChartGroupData> _buildBarGroups() {
    final data = [10.0, 12.5, 8.0, 15.0, 18.0, 14.0, 10.0];
    return List.generate(
      data.length,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: data[index],
            width: 20,
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: const Color(0xFF5CB1F5)),
          const SizedBox(height: 8),
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _getElapsedTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays} day(s) ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour(s) ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute(s) ago';
    } else {
      return 'Just now';
    }
  }
}