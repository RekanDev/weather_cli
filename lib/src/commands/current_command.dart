import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:io/io.dart';
import 'package:weather_cli/src/services/api_service.dart';

class CurrentCommand extends Command<int> {
  CurrentCommand(this.apiService) {
    argParser
      ..addOption(
        'q',
        abbr: 'q',
        help: 'Location name (e.g. city or country).',
        valueHelp: 'LOCATION',
      )
      ..addOption('name', abbr: 'n', valueHelp: 'LOCATION', hide: true);
  }

  final ApiService apiService;

  @override
  String get description =>
      'Get up-to-date current weather information for any location.\n'
      'Provides temperature, wind, condition, and more.';

  @override
  String get name => 'current';

  @override
  FutureOr<int>? run() async {
    final fromQ = (argResults?['q'] as String?)?.trim();
    final fromName = (argResults?['name'] as String?)?.trim();
    final q = fromQ?.isNotEmpty == true
        ? fromQ
        : fromName?.isNotEmpty == true
        ? fromName
        : null;

    if (q == null) {
      usageException('Missing required option: --q');
    }

    final weather = await apiService.getCurrent(query: q);

    if (weather == null) return ExitCode.data.code;

    final location = weather.location;
    final current = weather.current;

    final condition = current?.condition?.text ?? 'N/A';
    final tempC = current?.tempC ?? 'N/A';
    final feelslikeC = current?.feelslikeC ?? 'N/A';
    final windKph = current?.windKph ?? 'N/A';
    final windDir = current?.windDir ?? '';

    final locationLine = [
      if (location?.name != null) location!.name,
      if (location?.region != null) location!.region,
      if (location?.country != null) location!.country,
    ].join(', ');
    final locationText = locationLine.isEmpty
        ? 'Unknown location'
        : locationLine;

    final localtime = location?.localtime ?? 'N/A';

    print('''
${'================================'.greenBright}
${'Current weather for $locationText'}
${'================================'.greenBright}

${'Location   :'.cyan} ${locationText.white}
${'Localtime  :'.cyan} ${localtime.white}

${'Condition  :'.yellow} ${condition.white}
${'Temperature:'.magenta} ${(tempC != 'N/A' ? '$tempC °C' : 'N/A').white}
${'Feels like :'.magenta} ${(feelslikeC != 'N/A' ? '$feelslikeC °C' : 'N/A').white}
${'Wind       :'.green} ${(windKph != 'N/A' ? '$windKph kph $windDir' : 'N/A').white}
''');

    return ExitCode.success.code;
  }
}
