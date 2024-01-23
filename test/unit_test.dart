// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/docs/cookbook/testing/unit/introduction

import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/src/utils/date/date_helper.dart';

void main() {
  group('Test getFormatStoryTime', () {
    test('Null value', () {
      DateTime? inputDateTime;
      String result = DateHelper.getFormatStoryTime(inputDateTime);
      expect(result, "");
    });

    test('Test getFormatStoryTime function with just now', () {
      DateTime inputDateTime = DateTime.now();
      String result = DateHelper.getFormatStoryTime(inputDateTime);
      expect(result, "Just now");
    });

    test('Test getFormatStoryTime function with minutes ago', () {
      DateTime inputDateTime =
          DateTime.now().subtract(const Duration(minutes: 5));
      String result = DateHelper.getFormatStoryTime(inputDateTime);
      expect(result, "5 minutes ago");
    });

    test('Test getFormatStoryTime function with hours ago', () {
      DateTime inputDateTime =
          DateTime.now().subtract(const Duration(hours: 2));

      String result = DateHelper.getFormatStoryTime(inputDateTime);

      expect(result, "2 hours ago");
    });

    test('Test getFormatStoryTime function with days ago', () {
      DateTime inputDateTime = DateTime.now().subtract(const Duration(days: 3));

      String result = DateHelper.getFormatStoryTime(inputDateTime);

      expect(result, "3 days ago");
    });
  });
}
