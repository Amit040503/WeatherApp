import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();
  final TextEditingController _controller = TextEditingController();

  bool _isloading = false;
  Weather? _weather;

  void _getWeather() async {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Enter Your City Name")));
      return;
    }

    setState(() {
      _isloading = true;
    });

    try {
      final weatherData = await _weatherServices.fetchWeather(
        _controller.text.trim(),
      );

      setState(() {
        _weather = weatherData;
        _isloading = false;
      });
    } catch (e) {
      setState(() {
        _isloading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient:
              _weather != null &&
                  _weather!.description.toLowerCase().contains('rain')
              ? LinearGradient(
                  colors: [Colors.grey, Colors.blueGrey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : _weather != null &&
                    _weather!.description.toLowerCase().contains('clear')
              ? LinearGradient(
                  colors: [Colors.orangeAccent, Colors.blueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 25),
                Text(
                  'Weather App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 25),

                TextField(
                  controller: _controller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter your City Name",
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: const Color.fromARGB(111, 255, 255, 255),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _isloading ? null : _getWeather,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(244, 173, 202, 216),
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Get Weather', style: TextStyle(fontSize: 18)),
                ),

                if (_isloading)
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),

                if (_weather != null) WeatherCard(weather: _weather!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
