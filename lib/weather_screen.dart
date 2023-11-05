import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Resuable_widget.dart';
import 'package:weather_app/hourly_widgets.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  State<WeatherScreen> createState() => _WeatherScreen();
}

class _WeatherScreen extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final res = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=London,&APPID=966a04945da6d08171481f94b476192a'));

      final data = jsonDecode(res.body);

      if (int.parse(data['cod']) != 200) {
        throw 'An unexpected error';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                
                
              });
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          final data = snapshot.data!;
          final currentTempSky = data['list'][0];
          final currentWeather = currentTempSky['main']['temp'];
          final cloudtemp = currentTempSky['weather'][0]['main'];
          final currentPressure = currentTempSky['main']['pressure'];
          final currentHumidity = currentTempSky['main']['humidity'];
          final currentWindSpeed = currentTempSky['wind']['speed'];

          //display the current temperature

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    //clipRReact removes the blur(because i used backdropfilter) and adjust the border radius
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentWeather K',
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Icon(
                                cloudtemp == 'Rain' || cloudtemp == 'Clouds' ? Icons.cloud : Icons.sunny,
                                size: 64,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Rain',
                                style: TextStyle(fontSize: 24),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 40,
                      itemBuilder: (context, index) {
                        final reusable = data['list'][index + 1];
                        final showCast =
                            data['list'][index + 1]['weather'][0]['main'];
                        final time = DateTime.parse(reusable['dt_txt']);
                        return ReusableWidgets(
                          time: DateFormat.j().format(time),
                          temperature: reusable['main']['temp'].toString(),
                          iconData: showCast == 'Rain' || showCast == 'Clouds'
                              ? Icons.cloud
                              : Icons.sunny,
                        );
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnotherReusable(
                      title: 'Humidity',
                      iconData: Icons.water_drop,
                      title2: currentHumidity.toString(),
                    ),
                    AnotherReusable(
                      title: 'Wind Speed',
                      iconData: Icons.air,
                      title2: currentWindSpeed.toString(),
                    ),
                    AnotherReusable(
                        title: 'Pressure',
                        title2: currentPressure.toString(),
                        iconData: Icons.beach_access)
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
