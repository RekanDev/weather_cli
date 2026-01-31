import 'package:chalkdart/chalkstrings.dart';
import 'package:http/http.dart' as http;
import 'package:stack_trace/stack_trace.dart';
import 'package:weather_cli/src/models/forecast_weather.dart';
import 'package:weather_cli/src/models/weather.dart';

class ApiService {
  const ApiService();

  final _baseUrl = 'https://api.weatherapi.com/v1';

  final _apiKey = '82b3c0d7d2964f4f84e174122261901';

  Future<Weather?> getCurrent({required String query}) async {
    try {
      final trimmedQuery = query.trim();

      if (trimmedQuery.isEmpty) return null;

      final queryParameters = {'key': _apiKey, 'q': trimmedQuery};

      final uri = Uri.parse(
        '$_baseUrl/current.json',
      ).replace(queryParameters: queryParameters);

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      return Weather.fromJson(response.body);
    } catch (error, stackTrace) {
      print(
        'error while calling to current api:\nerror: $error\n${Chain.forTrace(stackTrace)}'
            .redBright,
      );

      return null;
    }
  }

  Future<ForecastWeather?> getForecast({
    required String query,
    required int days,
  }) async {
    try {
      final trimmedQuery = query.trim();

      if (trimmedQuery.isEmpty) return null;

      final clampedDays = days.clamp(1, 14);

      final queryParameters = {
        'key': _apiKey,
        'q': trimmedQuery,
        'days': clampedDays.toString(),
      };

      final uri = Uri.parse(
        '$_baseUrl/forecast.json',
      ).replace(queryParameters: queryParameters);

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      return ForecastWeather.fromJson(response.body);
    } catch (error, stackTrace) {
      print(
        'error while calling to forecast api:\nerror: $error\n${Chain.forTrace(stackTrace)}'
            .redBright,
      );

      return null;
    }
  }
}
