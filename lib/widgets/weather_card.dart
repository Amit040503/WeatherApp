import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  String formattime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final desc = weather.description.toLowerCase();

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(115, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Lottie.asset(
            desc.contains('rain')
                ? 'assets/rain.json'
                : desc.contains('clear')
                ? 'assets/sunny.json'
                : desc.contains('snow')
                ? 'assets/snowfall.json'
                : 'assets/cloudy.json',
            height: 150,
            width: 150,
          ),

          Text(
            weather.cityName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          SizedBox(height: 10),

          Text(
            '${weather.temperature.toStringAsFixed(1)} °C',
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 10),

          Text(
            weather.description,
            style: Theme.of(context).textTheme.titleMedium,
          ),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Humidity: ${weather.humidity}%',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Wind: ${weather.windSpeed} m/s',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.wb_sunny_outlined, color: Colors.orange),
                  Text('Sunrise'),
                  Text(formattime(weather.sunrise)),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.nights_stay_outlined, color: Colors.purple),
                  Text('Sunset'),
                  Text(formattime(weather.sunset)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
