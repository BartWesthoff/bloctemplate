import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Precision { year, month, day, hour, second, minute, short, long }

extension DatetimeConvert on DateTime {
  String dateString() {
    return DateFormat('dd-MM-y').format(this);
  }

  String format(String option) => DateFormat(option).format(this);

  String toTimeString({required Precision precision}) {
    if (precision == Precision.hour) {
      return DateFormat('HH').format(this);
    }
    if (precision == Precision.minute) {
      return DateFormat('HH:mm').format(this);
    }
    if (precision == Precision.second) {
      return DateFormat('HH:mm:ss').format(this);
    }
    throw Exception("Precision not met, choose hour, minute or second");
  }

  String toAppointmentDateString({required Precision precision}) {
    if (precision == Precision.year) {
      return DateFormat('EEEE d MMMM y HH:mm').format(this);
    } else if (precision == Precision.month) {
      return DateFormat('EEEE d MMMM HH:mm').format(this);
    } else if (precision == Precision.day) {
      return DateFormat('EEEE HH:mm').format(this);
    }
    throw Exception("Precision not met, choose year, month or day");
  }

  String toInput(String orginalInput) {
    final map = {
      'minute': 'mm',
      'hour': 'HH',
      'second': 'ss',
      'daynumber': 'dd',
      'daynumbershort': 'd',
      'daystring': 'EEEE',
      'daystringshort': 'EE',
      'monthnumber': 'M',
      'year': 'yyyy',
      'yearshort': 'yy',
      'january': 'MMMM',
      'february': 'MMMM',
      'march': 'MMMM',
      'april': 'MMMM',
      'may': 'MMMM',
      'june': 'MMMM',
      'july': 'MMMM',
      'august': 'MMMM',
      'september': 'MMMM',
      'october': 'MMMM',
      'november': 'MMMM',
      'december': 'MMMM',
      'jan': 'MMM',
      'monday': 'EEEE',
      'tuesday': 'EEEE',
      'wednesday': 'EEEE',
      'thursday': 'EEEE',
      'friday': 'EEEE',
      'saturday': 'EEEE',
      'sunday': 'EEEE',
      'mon': 'EE',
      'tue': 'EE',
      'wed': 'EE',
      'thu': 'EE',
      'fri': 'EE',
      'sat': 'EE',
      'sun': 'EE',
    };

    final String trimmed = orginalInput.trim();
    String input = trimmed.toLowerCase();

    while (input.contains('  ')) {
      input = input.replaceAll('  ', ' ');
    }

    for (final String element in input.split(' ')) {
      if (map.containsKey(element)) {
        input = input.replaceFirst(element, map[element]!);
      }

      // if statement makes it more efficient
      if (element.contains("-") ||
          element.contains("/") ||
          element.contains(":")) {
        for (final String key in map.keys) {
          if (element.contains(key)) {
            input = input.replaceFirst(key, map[key]!);
          }
        }
      }
    }

    return format(input);
  }

  bool operator >(DateTime other) {
    return isAfter(other);
  }

  bool operator <(DateTime other) {
    return isBefore(other);
  }

  bool operator <=(DateTime other) {
    return isBefore(other) || isAtSameMomentAs(other);
  }

  bool operator >=(DateTime other) {
    return isAfter(other) || isAtSameMomentAs(other);
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? millisecond,
    int? second,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  // datetime.minuteSince(9:00)
  double minuteSince(TimeOfDay timeOfDay) {
    final DateTime blankDate =
        copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute);
    return -blankDate.difference(this).inMinutes.toDouble();
  }
}
