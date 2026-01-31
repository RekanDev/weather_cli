import 'package:cli_completion/cli_completion.dart';
import 'package:io/io.dart';
import 'package:weather_cli/src/commands/current_command.dart';
import 'package:weather_cli/src/commands/forecast_command.dart';
import 'package:weather_cli/src/services/api_service.dart';

class WeatherCliCommand extends CompletionCommandRunner<int> {
  WeatherCliCommand(this.apiService)
    : super(
        'weather_cli',
        'weather cli to fetch weather information from api',
      ) {
    addCommand(CurrentCommand(apiService));
    addCommand(ForecastCommand(apiService));
  }

  final ApiService apiService;

  @override
  Future<int?> run(Iterable<String> args) async {
    try {
      return super.run(args);
    } catch (e) {
      return ExitCode.usage.code;
    }
  }
}
