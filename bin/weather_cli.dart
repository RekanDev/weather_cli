import 'package:weather_cli/weather_cli.dart';

void main(List<String> arguments) {
  WeatherCliCommand(ApiService()).run(arguments);
}
