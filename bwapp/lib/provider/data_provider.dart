import 'dart:convert';
import 'package:bwapp/models/condition.dart';
import 'package:bwapp/models/country.dart';
import 'package:bwapp/models/weatherDay.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  final String serverUrl = "http://10.0.2.2:8081";
  List<Country> countries = [];
  late int capacity;
  late String city;
  List<WeatherDay> weatherDays = [];
  List<Condition> conditions = [];

  Future<void> retriveCountries() async {
    final url = serverUrl + '/api/settings/countries';

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);

        extractedData = extractedData["countries"];

        extractedData.forEach((country) {
          List<String> cities = [];
          country["cities"].forEach((city) {
            cities.add(city);
          });
          countries.add(Country(name: country["country"], cities: cities));
        });
      }
    } catch (e) {
      print(e.toString());
    }
    //print(countries.length);
  }

  Future<void> loadCapacity() async {
    final url = serverUrl + '/api/settings';

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);

        capacity = extractedData["capacity"];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadWeather() async {
    List<WeatherDay> weatherDays = [];
    final url = serverUrl + '/api/settings/weather';

    final response = await http.post(Uri.parse(url), body: {"city": city});

    try {
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);

        extractedData = extractedData["forecastday"];
        extractedData.forEach((day) {
          weatherDays.add(WeatherDay(
              date: day['date'],
              sunrise: day['astro']['sunrise'],
              sunset: day['astro']['sunset'],
              temp: double.parse(day['day']['avgtemp_c'].toString()),
              rain: day['day']['daily_will_it_rain']));
        });
      }
    } catch (e) {
      print(e.toString());
    }
    weatherDays.forEach((element) {
      print(element.date);
      print(element.rain);
      print(element.sunrise);
      print(element.sunset);
      print(element.temp);
    });
  }

  Future<void> loadConditions() async {
    List<Condition> conditions = [];
    final url = serverUrl + '/api/conditions';

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);

        extractedData.forEach((data) {
          conditions.add(Condition(
            name: data['name'],
            interval: data['interval'],
            percentage: data['percentage'],
          ));
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadData() async {
    await loadConditions();
    await loadWeather();
    await loadCapacity();
  }
}
