import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';

class DetailKolam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme; 
    return Scaffold(
      backgroundColor: Color(0xFFEAF0FA),
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            GoRouter.of(context).go("/home");
          },
        ),
        title: Text("Detail Kolam", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF5CB1F5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Kolam Nila 4",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jenis Ikan",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            Text(
                              "Ikan Nila",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tanggal Budidaya",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            Text(
                              "20 Des 2024",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
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
            GridView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              children: [
                _buildInfoCard("pH kolam", "7", Icons.opacity),
                _buildInfoCard("Suhu kolam", "28°", Icons.thermostat),
                _buildInfoCard("Pakan", "30kg", Icons.food_bank),
                _buildInfoCard("Autofeeder 1", "15' 26\"", Icons.timer),
              ],
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Statistik Penggunaan Pakan",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5CB1F5)),
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
                              getTitlesWidget: (double value, TitleMeta meta) {
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
                              getTitlesWidget: (double value, TitleMeta meta) {
                                const style = TextStyle(
                                  color: Color(0xFF75729E),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8, 
                                );
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  space: 0,
                                  child: Text('${value.toInt()}kg', style: style),
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
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color(0xFF5CB1F5),
      //   onPressed: () {
      //   },
      //   child: Icon(Icons.add, color: Colors.white),
      // ),
    );
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
            color: Color(0xFF5CB1F5),
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
