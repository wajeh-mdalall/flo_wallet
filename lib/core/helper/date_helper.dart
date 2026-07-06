import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (dateToCheck == today) {
      return DateFormat('h:mm a').format(dateTime).toLowerCase();
    } else if (dateToCheck == today.subtract(const Duration(days: 1))) {
      return 'Yesterday, ${DateFormat('h:mm a').format(dateTime).toLowerCase()}';
    }
    if (dateTime.year == now.year) {
      return DateFormat('d MMM, h:mm a').format(dateTime).toLowerCase();
    } else {
      return DateFormat('d MMM y, h:mm a').format(dateTime).toLowerCase();
    }
  }

  static int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  static String formatBirthDate(DateTime dateTime, {bool withAge = false}) {
    final now = DateTime.now();
    final int age = calculateAge(dateTime);
    if (dateTime == now) {
      return "Date of birth is missing or invalid.";
    }
    final String formatedDate = DateFormat('d MMM y').format(dateTime);
    return withAge ? "$formatedDate  [Age : $age]" : formatedDate;
  }
}
