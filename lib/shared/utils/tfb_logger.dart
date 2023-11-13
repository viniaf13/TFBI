import 'dart:io' as io;
import 'dart:io';

import 'package:logger/logger.dart';

/// A singleton logger class shared throughout the entire app
class TfbLogger {
  static final logger = Logger(
    printer: PrettyPrinter(
      printTime: true,
      methodCount: 12,
      colors: io.stdout.supportsAnsiEscapes,
      printEmojis: false,
    ),

    /// Add more outputs here to support output to other sources, such as
    /// crashlytics or sentry.
    output: MultiOutputLog(
      logOutputs: [ConsoleOutputExceptWhenRunningTests()],
    )

    /// Change this filter level depending on how much information you want to
    /// see in the console while debugging.
    ///
    /// By default, this prints all logs.
    // filter: NoVerboseFilter(),
    ,
  );

  static void verbose(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.t(message, error: error, stackTrace: stackTrace);
  }

  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void exception(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    logger.e(message, error: error, stackTrace: stackTrace);
  }
}

class ConsoleOutputExceptWhenRunningTests extends LogOutput {
  @override
  void output(OutputEvent event) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) return;
    ConsoleOutput().output(event);
  }
}

class NoVerboseFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return event.level != Level.trace;
  }
}

class MultiOutputLog extends LogOutput {
  MultiOutputLog({
    required this.logOutputs,
  });

  List<LogOutput> logOutputs;

  @override
  void output(OutputEvent event) {
    for (final localOutput in logOutputs) {
      localOutput.output(event);
    }
  }
}
