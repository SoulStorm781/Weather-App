import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
import 'package:weather_app/screens/widgets/pressure_sealevel.dart';
import 'package:weather_app/screens/widgets/sunrise_sunset.dart';
import 'package:weather_app/screens/widgets/wind_humidity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getWeatherIcon(int code) {
    if (code >= 200 && code < 300) {
      return Image.asset('assets/images/1.png');
    } else if (code >= 300 && code < 400) {
      return Image.asset('assets/images/2.png');
    } else if (code >= 500 && code < 600) {
      return Image.asset('assets/images/3.png');
    } else if (code >= 600 && code < 700) {
      return Image.asset('assets/images/4.png');
    } else if (code >= 700 && code < 800) {
      return Image.asset('assets/images/5.png');
    } else if (code == 800) {
      return Image.asset('assets/images/6.png');
    } else if (code > 800 && code <= 804) {
      return Image.asset('assets/images/7.png');
    } else {
      return Image.asset('assets/images/7.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff1f005c),
            Color(0xff5b0060),
            Color(0xff870160),
            Color(0xffac255e),
            Color(0xffca485c),
            Color(0xffca485c),
            Color(0xffca485c),
            Color(0xffca485c),
            // Color(0xffe16b5c),
            // Color(0xfff39060),
            // Color(0xffffb56b),
          ],
          // color: Colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // color: Colors.black87,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('AF Weather Forecast',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onSubmitted: (city) {
                  if (city.isNotEmpty) {
                    context.read<WeatherBlocBloc>().add(FetchWeather(city));
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: 'Enter city name...',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 15),
          child: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
            builder: (context, state) {
              if (state is WeatherBlocLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WeatherBlocFailure) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              } else if (state is WeatherBlocSuccess) {
                return SizedBox(
                  width: Width,
                  height: Height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📍 ${state.weather.areaName}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '\t\t${state.weather.country}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Center(
                          child: getWeatherIcon(
                              state.weather.weatherConditionCode!),
                        ),
                        Center(
                          child: Text(
                              '${state.weather.temperature?.celsius?.round() ?? 'N/A'}°C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 55,
                                fontWeight: FontWeight.w500,
                              )),
                        ),

                        Center(
                          child: Text(state.weather.weatherMain!.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Temp Min: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '${state.weather.tempMin?.celsius?.roundToDouble() ?? 'N/A'}°C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              'Temp Max: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '${state.weather.tempMax?.celsius?.toStringAsFixed(2) ?? 'N/A'}°C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                              DateFormat('EEEE dd •')
                                  .add_jm()
                                  .format(state.weather.date!),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1.5)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Divider(
                          color: Colors.white70,
                          thickness: 0.5,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'Current conditions',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Wind and humidity
                        windHumidityWidget(
                            windSpeed: state.weather.windSpeed,
                            humidity: state.weather.humidity),
                        const SizedBox(
                          height: 20,
                        ),
                        // Pressure and sea level
                        PressureWindgustWidget(
                          pressure: state.weather.pressure,
                          windGust: state.weather.windGust,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Sunrise and sunset
                        SunriseSunsetWidget(
                          sunRise: state.weather.sunrise,
                          sunSet: state.weather.sunset,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text("Enter a city to fetch weather"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
