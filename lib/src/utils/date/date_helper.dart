import 'package:intl/intl.dart';
import 'date_time.ext.dart';

class DateHelper {
  static DateTime getEndDateOfMonth() {
    DateTime now = DateTime.now();

    return DateTime(now.year, now.month + 1, 0);
  }

  static DateTime getEndDateOfYear() {
    DateTime now = DateTime.now();
    return DateTime(now.year + 1, 1, 0);
  }

  static DateTime getEndDateOfWeek() {
    DateTime now = DateTime.now();
    return now.addDaysWithoutTime(DateTime.daysPerWeek - now.weekday + 1);
  }

  static String getDateChatDetails(DateTime time) {
    DateTime today = DateTime.now();
    if (time.year == today.year &&
        time.month == today.month &&
        time.day == today.day) {
      // Same day
      return DateFormat('hh:mm').format(time);
    } else if (today.in7Days(time)) {
      // Same week
      return DateFormat('EEE At hh:mm').format(time);
    } else if (time.year == today.year) {
      // Same year
      return DateFormat('MMMM dd At hh:mm').format(time);
    } else {
      // Other
      return DateFormat('MMMM dd yyyy').format(time);
    }
  }

  static String getFormatChatTime(DateTime time) {
    DateTime today = DateTime.now();
    if (time.year == today.year &&
        time.month == today.month &&
        time.day == today.day) {
      return DateFormat('HH:mm').format(time);
    } else {
      var now_1w = today.subtract(const Duration(days: 7));
      if (time.isAfter(now_1w)) {
        return DateFormat('EEEE - HH:mm').format(time);
      } else {
        if (time.year == today.year) {
          return DateFormat('dd/MM - HH:mm').format(time);
        } else {
          return DateFormat('dd/MM/yyyy - HH:mm').format(time);
        }
      }
    }
  }

  static String getTimeAudio(Duration time) {
    return "${time.inMinutes.remainder(60).toString().padLeft(2, "0")}"
        ":${time.inSeconds.remainder(60).toString().padLeft(2, "0")}";
  }

  static bool isTheSameTimeChat(DateTime time1, DateTime time2) {
    if (time1.year == time2.year &&
        time1.month == time2.month &&
        time1.day == time2.day &&
        time1.hour == time2.hour &&
        time1.minute == time2.minute) {
      return true;
    } else {
      return false;
    }
  }

  /// generates a [Month] object from the Nth index from the start-date

  static int getWeekDay(DateTime date, bool startWeekWithSunday) {
    if (startWeekWithSunday) {
      return date.weekday == DateTime.sunday ? 1 : date.weekday + 1;
    } else {
      return date.weekday;
    }
  }

  /// calculates the last of the week by calculating the remaining days in a
  /// standard week and evaluating if this week extends beyond the total days
  /// in that month, and capping it to the end of the month if it does
  static DateTime lastDayOfWeek(
    DateTime firstDayOfWeek,
    bool startWeekWithSunday,
  ) {
    int daysInMonth = firstDayOfWeek.daysInMonth;

    final dayOfWeek = getWeekDay(firstDayOfWeek, startWeekWithSunday);
    final restOfWeek = DateTime.daysPerWeek - dayOfWeek;

    return firstDayOfWeek.day + restOfWeek > daysInMonth
        ? DateTime(firstDayOfWeek.year, firstDayOfWeek.month, daysInMonth)
        : firstDayOfWeek.addDays(restOfWeek);
  }

  static DateTime findDayOfWeekInMonth(
    DateTime date,
    int dayOfWeek, {
    bool startWeekWithSunday = false,
  }) {
    date = date.removeTime();

    if (date.weekday ==
        (startWeekWithSunday ? DateTime.sunday : DateTime.monday)) {
      return date;
    } else {
      return date.subtract(
          Duration(days: getWeekDay(date, startWeekWithSunday) - dayOfWeek));
    }
  }

  static List<int> daysPerMonth(int year) => <int>[
        31,
        _isLeapYear(year) ? 29 : 28,
        31,
        30,
        31,
        30,
        31,
        31,
        30,
        31,
        30,
        31,
      ];

  /// efficient leap year calculation transcribed from a C stack overflow answer
  static bool _isLeapYear(int year) {
    return (year & 3) == 0 && ((year % 25) != 0 || (year & 15) == 0);
  }

  /// This method returns the number of spaces required before first valid based of the hidden weekdays.
  /// For example, if the first valid date falls on a Tuesday, that means that the weekday "monday"
  /// is hidden, which makes the first valid date index "1"
  static int getNoOfSpaceRequiredBeforeFirstValidDate(
    List<int> weekdaysToHide,
    int weekdayValueForFirstValidDay, [
    bool isSundayFirstDayOfWeek = false,
  ]) {
    final mondayWeekDayList = [1, 2, 3, 4, 5, 6, 7];
    final sundayWeekDayList = [7, 1, 2, 3, 4, 5, 6];

    mondayWeekDayList.removeWhere(
      (weekday) => weekdaysToHide.contains(weekday),
    );
    sundayWeekDayList.removeWhere(
      (weekday) => weekdaysToHide.contains(weekday),
    );

    return isSundayFirstDayOfWeek
        ? sundayWeekDayList.indexOf(weekdayValueForFirstValidDay)
        : mondayWeekDayList.indexOf(weekdayValueForFirstValidDay);
  }

  static String getFullDate(DateTime? date) {
    if (date == null) return "";
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  static String getFullDateTypeVN(DateTime? date) {
    if (date == null) return "";
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String getTime(DateTime? time) {
    if (time == null) return "";
    return DateFormat('hh:mm a').format(time);
  }

  static String getShortMonth(DateTime? date) {
    if (date == null) return "";
    return DateFormat('MMM').format(date);
  }

  static String getFormatStoryTime(DateTime? inputDateTime) {
    if (inputDateTime == null) return "";
    final now = DateTime.now();
    final difference = now.difference(inputDateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      final minutes = difference.inMinutes;
      return '$minutes minute${minutes > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 1) {
      final hours = difference.inHours;
      return '$hours hour${hours > 1 ? 's' : ''} ago';
    } else {
      final days = difference.inDays;
      return '$days day${days > 1 ? 's' : ''} ago';
    }
  }

  /// MMM dd, yyyy - hh:mm a
  static String getFullDateTime(DateTime? date) {
    if (date != null) return DateFormat('MMM dd, yyyy - hh:mm a').format(date);
    return "";
  }

  /// MMMM dd, yyyy - hh:mm a
  static String getFullDateTimeFullMonth(DateTime? date) {
    if (date != null) return DateFormat('MMMM dd, yyyy - hh:mm a').format(date);
    return "";
  }
}
