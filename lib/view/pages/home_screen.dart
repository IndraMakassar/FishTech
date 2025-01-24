import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:fishtech/const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Makassar").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF37AFE1),
        title: const Text("Home"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5), 
        ),
        constraints: const BoxConstraints.expand(), 
        child: _buildUI(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).go('/add');
        },
        backgroundColor: const Color(0xFF37AFE1), // Match the app's theme color
        child: const Icon(Icons.add, color: Colors.white), // FAB icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Position the FAB
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildWeatherCard(),
          const SizedBox(height: 10),
          _buildCard("Kolam nila 1", ["1 autofeeder", "3kg", "pH = 7", "suhu = 27°C"]),
          const SizedBox(height: 15),
          _buildCard("Kolam nila 2", ["2 autofeeder", "5kg", "pH = 6", "suhu = 26°C"]),
          const SizedBox(height: 15),
          _buildCard("Kolam nila 3", ["3 autofeeder", "4kg", "pH = 7", "suhu = 28°C"]),
          const SizedBox(height: 20,),
          const Text("Find more about your fish", style: TextStyle(fontSize: 12),),
          const SizedBox(height: 20),
          _buildActionCard("Check your fish condition", Icons.camera_alt),
          const SizedBox(height: 20),
          _buildTextCard("Find more information about your fish"),
          const SizedBox(height: 20),

         
        ],
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Stack(
            children: [
              const Positioned(
                top: 10,
                left: 10,
                child: Text(
                  "TODAY",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF37AFE1),
                  ),
                ),
              ),
              Positioned(
                top: 35,
                left: 10,
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFF37AFE1),
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _weather?.areaName ?? "Makassar",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF37AFE1),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: _dateInfo(),
              ),
              Positioned(
                top: 55,
                left: 50,
                child: _currentTemp(),
              ),
              Positioned(
                right: 20,
                child: _weatherIcon(),
              ),
            ],
          ),
        ),
      ),
    );

  }

  Widget _buildCard(String title, List<String> details) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).go("/details");
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF37AFE1),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: details
                    .map((detail) => Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            detail,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Icon(icon, size: 24, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildTextCard(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _dateInfo() {
    DateTime now = _weather!.date!;
    return Text(
      "${DateFormat("EEEE").format(now)}, ${DateFormat("d MMM y").format(now)}",
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF37AFE1),
      ),
    );
  }

  Widget _weatherIcon() {
    return Container(
      height: 150,
      width: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)} °C",
      style: const TextStyle(
        color: Color(0xFF37AFE1),
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
