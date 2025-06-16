part of 'pages.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String? _selectedPondId;
  List<Map<String, dynamic>>? _filteredData;
  @override
  void initState(){
    super.initState();
    context.read<PondBloc>().add(const FetchPond());
  }

  void _updateStatistics() {
    if (_selectedPondId != null && _dropdownValue4 != 'Information Type') {
      final DateTime now = DateTime.now().toUtc(); // Use current UTC time
      DateTime startDate;
      DateTime endDate;


      switch (_selectedTimeRange) {
        case 'Day':
          startDate = DateTime.utc(now.year, now.month, now.day);
          endDate = startDate.add(Duration(days: 1));
          break;
        case 'Week':
        // Start from beginning of current week in UTC
          startDate = now.subtract(Duration(days: now.weekday - 1));
          startDate = DateTime.utc(startDate.year, startDate.month, startDate.day);
          endDate = startDate.add(Duration(days: 7));
          break;
        case 'Month':
          startDate = DateTime.utc(now.year, now.month, 1);
          if (now.month == 12) {
            endDate = DateTime.utc(now.year + 1, 1, 1); // Tahun berikutnya, Januari
          } else {
            endDate = DateTime.utc(now.year, now.month + 1, 1); // Bulan berikutnya
          }
          break;

        case 'Year':
        // Start from beginning of current year in UTC
          startDate = DateTime.utc(now.year, 1, 1);
          endDate = DateTime.utc(now.year + 1, 1, 1);
          break;
        default:
          startDate = DateTime.utc(now.year, now.month, now.day);
          endDate = startDate.add(Duration(days: 1));
      }

      context.read<PondBloc>().add(FetchFilteredData(
        infoType: _dropdownValue4,
        pondId: _selectedPondId!,
        startDate: startDate,
        endDate: endDate,
      ));
    }
  }



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

  // Replace _dayOptions with timeRangeOptions
  final List<String> _timeRangeOptions = ['Day', 'Week', 'Month', 'Year'];
  String _selectedTimeRange = 'Day';
  final List<String> _infoTypeOptions = ['Information Type', 'Feed', 'pH', 'temp'];

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
    final List<PondCardModel> pondList;

    if (state is PondSuccess) {
      pondList = state.ponds;
    } else if (state is FilteredDataSuccess) {
      pondList = state.ponds;
    } else if (state is PondLoading) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (state is PondFailure) {
      return Text("Failed: ${state.message}");
    } else {
      return const SizedBox();
    }

    // Extract dropdown options
    final pondOptions = ['Fish Pond', ...pondList.map((e) => e.name).toSet()];
    final fishOptions = ['Fish Type', ...pondList.map((e) => e.fish!).toSet()];

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        _buildDropdown('Fish Pond', _dropdownValue1, pondOptions, (val) {
          setState(() {
            _dropdownValue1 = val!;
            if (val != 'Fish Pond') {
              _selectedPondId = pondList.firstWhere((pond) => pond.name == val).id;
              _updateStatistics();
            }
          });
        }),
        _buildDropdown('Fish Type', _dropdownValue2, fishOptions, (val) {
          setState(() => _dropdownValue2 = val!);
        }),
        _buildDropdown('Time Range', _selectedTimeRange, _timeRangeOptions, (val) {
          setState(() {
            _selectedTimeRange = val!;
            _updateStatistics();
          });
        }),
        _buildDropdown('Information Type', _dropdownValue4, _infoTypeOptions,
                (val) {
              setState(() {
                _dropdownValue4 = val!;
                _updateStatistics();
              });
            }),
      ],
    );
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
  return BlocConsumer<PondBloc, PondState>(
    listener: (context, state) {
      if (state is FilteredDataSuccess) {
        setState(() {
          _filteredData = state.data;
        });
      }
    },
    builder: (context, state) {
      // Calculate averages first
      final Map<String, List<double>> groupedValues = {};
      if (_filteredData != null && _filteredData!.isNotEmpty) {
        for (var data in _filteredData!) {
          final DateTime date = DateTime.parse(data['created_at']);
          String key;

          switch (_selectedTimeRange) {
            case 'Day':
              key = date.hour.toString();
              break;
            case 'Week':
              key = _getDayName(date.weekday);
              break;
            case 'Month':
              key = date.day.toString();
              break;
            default:
              key = date.hour.toString();
          }

          final value = _dropdownValue4 == 'Feed'
              ? (data['food_amount'] as num).toDouble()
              : (data['reading'] as num).toDouble();

          if (!groupedValues.containsKey(key)) {
            groupedValues[key] = [];
          }
          groupedValues[key]!.add(value);
        }
      }

      // Calculate min and max from averages
      double? minY, maxY;
      groupedValues.forEach((key, values) {
        if (values.isNotEmpty) {
          double average = values.reduce((a, b) => a + b) / values.length;
          minY = minY == null ? average : min(minY!, average);
          maxY = maxY == null ? average : max(maxY!, average);
        }
      });

      // Adjust min and max by 0.5
      minY = (minY ?? 0) - 1;
      maxY = (maxY ?? 0) + 1;

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
            Text(
              _getChartTitle(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3c6090),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(right: 20), // Add right padding to balance the chart
                child: state is PondLoading
                    ? const Center(child: CircularProgressIndicator())
                    : LineChart(
                        LineChartData(
                          minY: minY,
                          maxY: maxY,
                          lineBarsData: [_buildLineData(context)],
                          titlesData: _buildTitlesData(),
                          borderData: FlBorderData(show: false),
                          gridData: const FlGridData(show: false),
                          lineTouchData: LineTouchData(
                            enabled: true,
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipColor: (touchedSpot) => Theme.of(context).colorScheme.primary,
                              tooltipRoundedRadius: 8,
                              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                                return touchedBarSpots.map((barSpot) {
                                  final unit = _dropdownValue4 == 'Feed' ? 'kg' :
                                  _dropdownValue4 == 'pH' ? '' : '°C';

                                  String timeLabel;
                                  switch (_selectedTimeRange) {
                                    case 'Day':
                                      final hour = barSpot.x.toInt();
                                      final formattedHour = hour.toString().padLeft(2, '0');
                                      final formattedMinute = '00';
                                      timeLabel = '$formattedHour:$formattedMinute';
                                      break;

                                    case 'Week':
                                      final dayIndex = barSpot.x.toInt() + 1;
                                      final dayName = _getDayName(dayIndex);
                                      // Use January 16, 2025 as the base date (Monday)
                                      final baseDate = DateTime(2025, 1, 16); // This is a Monday
                                      final date = baseDate.add(Duration(days: barSpot.x.toInt()));
                                      timeLabel = '$dayName, ${date.day} ${_getMonthName(date.month)}';
                                      break;

                                    case 'Month':
                                      final day = barSpot.x.toInt() + 1;
                                      final now = DateTime.now();
                                      final date = DateTime(now.year, now.month, day);
                                      timeLabel = '${date.day} ${_getMonthName(date.month)} ${date.year}';
                                      break;

                                    case 'Year':
                                      final month = barSpot.x.toInt() + 1;
                                      final now = DateTime.now();
                                      timeLabel = '${_getMonthName(month)} ${now.year}';
                                      break;

                                    default:
                                      timeLabel = '';
                                  }

                                  return LineTooltipItem(
                                    _selectedTimeRange == 'Year'
                                        ? '$timeLabel, ${barSpot.y.toStringAsFixed(1)}'
                                        : '$timeLabel, ${barSpot.y.toStringAsFixed(2)}$unit',
                                    const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                        ),
                    ),
              ),

            ),
          ],
        ),
      );
    },
  );
}

String _getChartTitle() {
  if (_dropdownValue4 == 'Information Type') return 'Select Information Type';
  String timeFrame = _selectedTimeRange == 'Day' ? 'Hourly' :
                     _selectedTimeRange == 'Week' ? 'Daily' : 'Daily';
  return 'Average $timeFrame ${_dropdownValue4} Data';
}

List<BarChartGroupData> _buildBarGroups(BuildContext context) {
  if (_filteredData == null || _filteredData!.isEmpty) {
    return [];
  }

  final Map<String, double> groupedData = {};

  for (var data in _filteredData!) {
    final DateTime date = DateTime.parse(data['created_at']);
    String key;

    switch (_selectedTimeRange) {
      case 'Day':
        // Group by hour
        key = date.hour.toString().padLeft(2, '0');
        break;
      case 'Week':
        // Group by day of week
        key = _getDayName(date.weekday);
        break;
      case 'Month':
        // Group by day of month
        key = date.day.toString();
        break;
      default:
        key = date.hour.toString();
    }

    final value = _dropdownValue4 == 'Feed'
        ? (data['food_amount'] as num).toDouble()
        : (data['reading'] as num).toDouble();

    groupedData[key] = (groupedData[key] ?? 0) + value;
  }

  // Sort the data
  var sortedEntries = groupedData.entries.toList()
    ..sort((a, b) {
      if (_selectedTimeRange == 'Week') {
        // Sort by day of week
        return _getDayIndex(a.key).compareTo(_getDayIndex(b.key));
      }
      return a.key.compareTo(b.key);
    });

  return sortedEntries.asMap().entries.map((entry) {
    return BarChartGroupData(
      x: entry.key,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: entry.value.value,
          width: 20,
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }).toList();
}

String _getDayName(int weekday) {
  switch (weekday) {
    case 1: return 'Mon';
    case 2: return 'Tue';
    case 3: return 'Wed';
    case 4: return 'Thu';
    case 5: return 'Fri';
    case 6: return 'Sat';
    case 7: return 'Sun';
    default: return '';
  }
}

int _getDayIndex(String dayName) {
  switch (dayName) {
    case 'Mon': return 1;
    case 'Tue': return 2;
    case 'Wed': return 3;
    case 'Thu': return 4;
    case 'Fri': return 5;
    case 'Sat': return 6;
    case 'Sun': return 7;
    default: return 0;
  }
}

FlTitlesData _buildTitlesData() {
  return FlTitlesData(
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
        interval: _selectedTimeRange == 'Day' ? 3 : 1,
        reservedSize: 45,
        getTitlesWidget: (value, meta) {
          const style = TextStyle(
            color: Color(0xFF75729E),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          );

          String label;
          switch (_selectedTimeRange) {
            case 'Day':
              final hour = value.toInt();
              if (hour % 3 == 0) {
                if (hour == 0) {
                  label = '12 AM';
                } else if (hour == 12) {
                  label = '12 PM';
                } else if (hour > 12) {
                  label = '${hour - 12} PM';
                } else {
                  label = '$hour AM';
                }
              } else {
                label = '';
              }
              break;
            case 'Week':
              final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
              if (value.toInt() < days.length) {
                label = days[value.toInt()];
              } else {
                label = '';
              }
              break;
            case 'Month':
              final day = value.toInt() + 1;
              final now = DateTime.now();
              final date = DateTime(now.year, now.month, day);
              label = '${date.day} ${_getMonthName(date.month)}';
              // Only show every 5th day to prevent overcrowding
              if (day % 5 != 0 && day != 1) {
                label = '';
              }
              break;
            case 'Year':
              final month = value.toInt() + 1;
              if (month >= 1 && month <= 12) {
                label = _getMonthName(month);
              } else {
                label = '';
              }
              break;
            default:
              label = value.toInt().toString();
          }

          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SideTitleWidget(
              axisSide: meta.axisSide,
              space: 12,
              angle: 45,
              child: Text(
                label,
                style: style,
              ),
            ),
          );
        },
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 5,
        reservedSize: 45, // Reduced back to 45
        getTitlesWidget: (value, meta) {
          const style = TextStyle(
            color: Color(0xFF75729E),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          );
          final unit = _dropdownValue4 == 'Feed'
              ? 'kg'
              : _dropdownValue4 == 'pH'
                  ? ''
                  : '°C';
          return Padding(
            padding: const EdgeInsets.only(right: 8), // Add padding to move text left
            child: SideTitleWidget(
              axisSide: meta.axisSide,
              space: 0, // Reset space to 0
              child: Text(
                '${value.toInt()}$unit',
                style: style,
              ),
            ),
          );
        },
      ),
    ),
  );
}

LineChartBarData _buildLineData(BuildContext context) {
  if (_filteredData == null || _filteredData!.isEmpty) {
    print('DEBUG: No filtered data available');
    return LineChartBarData(spots: []);
  }

  print('\nDEBUG: ====== START OF DATA PROCESSING ======');
  print('DEBUG: Time Range: $_selectedTimeRange');
  print('DEBUG: Info Type: $_dropdownValue4');
  print('DEBUG: Total data points: ${_filteredData!.length}');

  // First, sort the data by date
  _filteredData!.sort((a, b) => DateTime.parse(a['created_at'])
      .compareTo(DateTime.parse(b['created_at'])));

  // Debug raw data with timestamps
  print('\nDEBUG: RAW DATA (chronological order):');
  for (var data in _filteredData!) {
    final DateTime date = DateTime.parse(data['created_at']).toLocal();
    final value = _dropdownValue4 == 'Feed'
        ? (data['food_amount'] as num).toDouble()
        : (data['reading'] as num).toDouble();

    print('Date: ${date.toString()} (${_getDayName(date.weekday)})');
    print('  Hour: ${date.hour}');
    print('  Day: ${date.day}');
    print('  Month: ${_getMonthName(date.month)}');
    print('  Value: $value');
  }

  // Create a map to store readings for each time period
  final Map<String, List<Map<String, dynamic>>> timeGroupedReadings = {};

  // Group data points
  for (var data in _filteredData!) {
    final DateTime date = DateTime.parse(data['created_at']).toLocal();
    String key;

    switch (_selectedTimeRange) {
      case 'Day':
        key = date.hour.toString();
        break;
      case 'Week':
        key = _getDayName(date.weekday);
        break;
      case 'Month':
        key = date.day.toString();
        break;
      case 'Year':
        key = date.month.toString();
        break;
      default:
        key = date.hour.toString();
    }

    if (!timeGroupedReadings.containsKey(key)) {
      timeGroupedReadings[key] = [];
    }

    timeGroupedReadings[key]!.add({
      'date': date,
      'value': _dropdownValue4 == 'Feed'
          ? (data['food_amount'] as num).toDouble()
          : (data['reading'] as num).toDouble(),
    });
  }

  // Debug grouped data
  print('\nDEBUG: GROUPED DATA:');
  timeGroupedReadings.forEach((key, dataList) {
    print('\n$key:');
    for (var data in dataList) {
      print('  ${data['date']} -> ${data['value']}');
    }
  });

  // Calculate averages
  final Map<String, double> averagedData = {};
  timeGroupedReadings.forEach((key, dataList) {
    if (dataList.isNotEmpty) {
      double sum = dataList.fold(0.0, (prev, data) => prev + data['value']);
      double average = sum / dataList.length;
      averagedData[key] = average;

      print('\nDEBUG: Average calculation for $key:');
      print('  Number of values: ${dataList.length}');
      print('  Sum: $sum');
      print('  Average: $average');
    }
  });

  // Sort entries
  var sortedEntries = averagedData.entries.toList()
    ..sort((a, b) {
      if (_selectedTimeRange == 'Week') {
        return _getDayIndex(a.key).compareTo(_getDayIndex(b.key));
      }
      return int.parse(a.key).compareTo(int.parse(b.key));
    });

  print('\nDEBUG: FINAL SORTED AVERAGES:');
  sortedEntries.forEach((entry) {
    print('${entry.key}: ${entry.value}');
  });

  // Convert to spots
  final spots = sortedEntries.asMap().entries.map((entry) {
    double x;
    switch (_selectedTimeRange) {
      case 'Week':
        x = _getDayIndex(entry.value.key) - 1.0;
        break;
      case 'Month':
        x = double.parse(entry.value.key) - 1;
        break;
      case 'Year':
        x = double.parse(entry.value.key) - 1;
        break;
      default:
        x = double.parse(entry.value.key);
    }
    return FlSpot(x, entry.value.value);
  }).toList();

  print('\nDEBUG: ====== END OF DATA PROCESSING ======\n');

  return LineChartBarData(
    spots: spots,
    isCurved: true,
    color: Theme.of(context).colorScheme.primary,
    barWidth: 3,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true),
    belowBarData: BarAreaData(
      show: true,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
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

  String _getMonthName(int month) {
    switch (month) {
      case 1: return 'Jan';
      case 2: return 'Feb';
      case 3: return 'Mar';
      case 4: return 'Apr';
      case 5: return 'May';
      case 6: return 'Jun';
      case 7: return 'Jul';
      case 8: return 'Aug';
      case 9: return 'Sep';
      case 10: return 'Oct';
      case 11: return 'Nov';
      case 12: return 'Dec';
      default: return '';
    }
  }
}