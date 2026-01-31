import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:io/io.dart';
import 'package:weather_cli/src/services/api_service.dart';

class ForecastCommand extends Command<int> {
  ForecastCommand(this.apiService) {
    argParser
      ..addOption(
        'q',
        abbr: 'q',
        help: 'Location name (e.g. city or country).',
        valueHelp: 'LOCATION',
        mandatory: true,
      )
      ..addOption(
        'days',
        abbr: 'd',
        help: 'Number of days to forecast (1-14).',
        valueHelp: 'DAYS',
        defaultsTo: '3',
      );
  }

  final ApiService apiService;

  @override
  String get description =>
      'Get multi-day weather forecast, including daily conditions, temperatures, and wind.';

  @override
  String get name => 'forecast';

  @override
  FutureOr<int>? run() async {
    final q = (argResults?['q'] as String?)?.trim();

    if (q == null || q.isEmpty) {
      usageException('Missing required option: --q');
    }

    final daysRaw = (argResults?['days'] as String?)?.trim();
    final days = int.tryParse(daysRaw ?? '3') ?? 3;

    final forecastWeather = await apiService.getForecast(query: q, days: days);

    if (forecastWeather == null) return ExitCode.data.code;

    final location = forecastWeather.location;
    final forecast = forecastWeather.forecast;
    final forecastDays = forecast?.forecastday ?? const [];

    if (forecastDays.isEmpty) {
      stderr.writeln('No forecast data returned for "$q".');

      return ExitCode.data.code;
    }

    final locationLine = [
      if (location?.name != null) location!.name,
      if (location?.region != null) location!.region,
      if (location?.country != null) location!.country,
    ].join(', ');

    final locationText = locationLine.isEmpty
        ? 'Unknown location'
        : locationLine;
    final localtime = location?.localtime ?? 'N/A';

    final buffer = StringBuffer()
      ..writeln('''
${'================================'.greenBright}
${'Forecast for $locationText (next $days day${days == 1 ? '' : 's'})'}
${'================================'.greenBright}

${'Location   :'.cyan} ${locationText.white}
${'Localtime  :'.cyan} ${localtime.white}
''');

    for (final day in forecastDays.take(days)) {
      final date = day.date ?? 'N/A';
      final dayData = day.day;
      final conditionText = dayData?.condition?.text ?? 'N/A';
      final maxC = dayData?.maxtempC ?? 'N/A';
      final minC = dayData?.mintempC ?? 'N/A';
      final avgC = dayData?.avgtempC ?? 'N/A';
      final maxWindKph = dayData?.maxwindKph ?? 'N/A';

      buffer.writeln('''
${'--- $date ---'.greenBright}
${'Condition   :'.yellow} ${conditionText.white}
${'Temp (°C)   :'.magenta} max ${maxC.toString()} / min ${minC.toString()} / avg ${avgC.toString()}
${'Wind        :'.green} ${(maxWindKph != 'N/A' ? '$maxWindKph kph' : 'N/A')}
''');
    }

    print(buffer.toString());

    return ExitCode.success.code;
  }
}
