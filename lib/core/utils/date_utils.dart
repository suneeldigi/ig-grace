// lib/core/utils/date_utils.dart
// Love timer utility for calculating relationship duration

import 'package:my_wifeu_my_grace/core/constants/app_constants.dart';

class LoveDateUtils {
  LoveDateUtils._();

  /// Returns the exact DateTime when they first met
  static DateTime get meetDateTime => DateTime(
        AppConstants.meetYear,
        AppConstants.meetMonth,
        AppConstants.meetDay,
        AppConstants.meetHour,
        AppConstants.meetMinute,
        AppConstants.meetSecond,
      );

  /// Returns a [LoveDuration] object with all time components
  static LoveDuration calculateLoveDuration() {
    final now = DateTime.now();
    final meetDate = meetDateTime;

    // If meeting is in the future, return zeros
    if (now.isBefore(meetDate)) {
      return const LoveDuration(
        years: 0,
        months: 0,
        days: 0,
        hours: 0,
        minutes: 0,
        seconds: 0,
        totalSeconds: 0,
      );
    }

    int years = now.year - meetDate.year;
    int months = now.month - meetDate.month;
    int days = now.day - meetDate.day;
    int hours = now.hour - meetDate.hour;
    int minutes = now.minute - meetDate.minute;
    int seconds = now.second - meetDate.second;

    // Normalize seconds
    if (seconds < 0) {
      seconds += 60;
      minutes--;
    }

    // Normalize minutes
    if (minutes < 0) {
      minutes += 60;
      hours--;
    }

    // Normalize hours
    if (hours < 0) {
      hours += 24;
      days--;
    }

    // Normalize days
    if (days < 0) {
      final lastMonth = DateTime(now.year, now.month, 0);
      days += lastMonth.day;
      months--;
    }

    // Normalize months
    if (months < 0) {
      months += 12;
      years--;
    }

    final totalSeconds = now.difference(meetDate).inSeconds;

    return LoveDuration(
      years: years,
      months: months,
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      totalSeconds: totalSeconds,
    );
  }

  /// Formats a DateTime to display string
  static String formatMeetDate() {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final d = meetDateTime;
    final hour = d.hour > 12 ? d.hour - 12 : d.hour;
    final amPm = d.hour >= 12 ? 'PM' : 'AM';
    return '${d.day} ${months[d.month]} ${d.year} at ${hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')} $amPm';
  }

  /// Formats current date nicely
  static String formatCurrentDate(DateTime now) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final dayName = days[now.weekday - 1];
    return '$dayName, ${now.day} ${months[now.month]} ${now.year}';
  }

  /// Formats current time (live)
  static String formatCurrentTime(DateTime now) {
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final amPm = now.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')} $amPm';
  }
}

/// Data class holding all components of love duration
class LoveDuration {
  final int years;
  final int months;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final int totalSeconds;

  const LoveDuration({
    required this.years,
    required this.months,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.totalSeconds,
  });
}
