part of 'pages.dart';

class DetailKolam extends StatefulWidget {
  const DetailKolam({Key? key}) : super(key: key);

  @override
  _DetailKolamState createState() => _DetailKolamState();
}

class _DetailKolamState extends State<DetailKolam> {
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: Color(0xFFF9F9FF),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).push('/addPond');
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 38,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: Header(
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
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E2EC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Kolam Ikan Nila 1",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
                                Text(
                                  "Jenis Ikan",
                                  style: TextStyle(
                                      color: Color(0xFF43474E), fontSize: 14),
                                ),
                                Text(
                                  "Ikan Nila",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Port Size",
                                  style: TextStyle(
                                      color: Color(0xFF43474E), fontSize: 14),
                                ),
                                Text(
                                  "1.000.000 m3",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tanggal Budidaya",
                                  style: TextStyle(
                                      color: Color(0xFF43474E), fontSize: 14),
                                ),
                                Text(
                                  "20 Des 2024",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Sensors",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    GridView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 12,
                      ),
                      children: [
                        _buildInfoCard("pH ", "7", Icons.opacity),
                        _buildInfoCard(
                            "Temperature", "27° C", Icons.thermostat),
                        _buildInfoCard("Food Used/day", "3kg", Icons.food_bank),
                        _buildInfoCard("Last Autofeeder", "15 Hours 14 Minutes",
                            Icons.timer),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Statistics",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(0, 4))
                      ]),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Use of Fish Feed",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF43474e)),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 200,
                        child: BarChart(
                          BarChartData(
                            barGroups: _buildBarGroups(),
                            titlesData: FlTitlesData(
                              show: true,
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
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
                                        text = Text('Mon', style: style);
                                        break;
                                      case 1:
                                        text = Text('Tue', style: style);
                                        break;
                                      case 2:
                                        text = Text('Wed', style: style);
                                        break;
                                      case 3:
                                        text = Text('Thu', style: style);
                                        break;
                                      case 4:
                                        text = Text('Fri', style: style);
                                        break;
                                      case 5:
                                        text = Text('Sat', style: style);
                                        break;
                                      case 6:
                                        text = Text('Sun', style: style);
                                        break;
                                      default:
                                        text = Text('', style: style);
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
                            gridData: FlGridData(show: false),
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Color(0xFF5CB1F5)),
          SizedBox(height: 8),
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          Text(value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}