import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('tap test', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('tap', () async {
      final Timeline timeline = await driver.traceAction(() async {
        // Tap 3 times
        await driver.tap(find.byType('Circles'));
        await driver.tap(find.byType('Circles'));
        await driver.tap(find.byType('Circles'));
      });

      TimelineSummary.summarize(timeline)
        // Then, save the summary to disk
        ..writeSummaryToFile('tap_circles', pretty: true)
        // Optionally, write the entire timeline to disk in a json format. This
        // file can be opened in the Chrome browser's tracing tools found by
        // navigating to chrome://tracing.
        ..writeTimelineToFile('tap_circles', pretty: true);
    });
  });
}
