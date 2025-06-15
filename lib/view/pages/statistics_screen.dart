part of 'pages.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  void initState(){
    super.initState();
    context.read<PondBloc>().add(const FetchPond());
  }
  final List<double> _weeklyData = [10.0, 12.5, 8.0, 15.0, 18.0, 14.0, 10.0];
  final List<Map<String, dynamic>> _ponds = [
    {'title': 'Kolam Nila 1', 'details': ['Fish Feed', '5kg']},
    {'title': 'Kolam Nila 2', 'details': ['Fish Feed', '5kg']},
    {'title': 'Kolam Nila 3', 'details': ['Fish Feed', '5kg']},
    {'title': 'Kolam Nila 4', 'details': ['Fish Feed', '5kg']},
  ];


  String _dropdownValue1 = 'Fish Pond';
  String _dropdownValue2 = 'Fish Type';
  String _dropdownValue3 = 'Day';
  String _dropdownValue4 = 'Information Type';

  final List<String> _dayOptions = ['Day', 'Mon', 'Tue', 'Wed'];
  final List<String> _infoTypeOptions = ['Information Type', 'Feed', 'pH', 'Temp'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Statistics', showBackButton: true),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            GoRouter.of(context).go('/details');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Statistics",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                BlocBuilder<PondBloc, PondState>(
                  builder: (context, state) {
                    if (state is PondSuccess) {
                      final pondList = state.ponds;

                      // Extract dropdown options
                      final pondOptions = ['Fish Pond', ...pondList.map((e) => e.name).toSet()];
                      final fishOptions = ['Fish Type', ...pondList.map((e) => e.fish!).toSet()];

                      // You can keep day/infoType statically like before
                      return Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          _buildDropdown('Fish Pond', _dropdownValue1, pondOptions, (val) {
                            setState(() => _dropdownValue1 = val!);
                          }),
                          _buildDropdown('Fish Type', _dropdownValue2, fishOptions, (val) {
                            setState(() => _dropdownValue2 = val!);
                          }),
                          _buildDropdown('Day', _dropdownValue3, _dayOptions, (val) {
                            setState(() => _dropdownValue3 = val!);
                          }),
                          _buildDropdown('Information Type', _dropdownValue4, _infoTypeOptions,
                                  (val) {
                                setState(() => _dropdownValue4 = val!);
                              }),
                        ],
                      );
                    } else if (state is PondLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is PondFailure) {
                      return Text("Failed: ${state.message}");
                    }
                    return const SizedBox();
                  },
                ),


                const SizedBox(height: 16),

                _buildStatisticCard(context),
                const SizedBox(height: 25),
                const Text("History",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                ..._ponds.map((pond) => Column(
                      children: [
                        _buildCard(pond['title'], pond['details']),
                        const SizedBox(height: 8),
                      ],
                    )),
              ],
            ),
          );
        },
      ),
      backgroundColor: const Color(0xFFe0e2ec),
    );
  }

  Widget _buildDropdown(String hint, String currentValue, List<String> options,
      ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFC3C6CF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: onChanged,
          style: const TextStyle(color: Colors.black),
          dropdownColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStatisticCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Use of Fish Feed",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3c6090),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                barGroups: _buildBarGroups(context),
                titlesData: _buildTitlesData(),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                barTouchData: BarTouchData(enabled: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(BuildContext context) {
    return List.generate(
      _weeklyData.length,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: _weeklyData[index],
            width: 20,
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true,
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            const style = TextStyle(
              color: Color(0xFF75729E),
              fontWeight: FontWeight.bold,
              fontSize: 10,
            );
            const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            final index = value.toInt();
            final text = (index >= 0 && index < days.length)
                ? Text(days[index], style: style)
                : const Text('', style: style);
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
          getTitlesWidget: (value, meta) {
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
    );
  }

  Widget _buildCard(String title, List<String> details) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).go("/");
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFf3f3fa),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Fish Feed",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Today",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  details[1],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
