import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../app.dart';

class THelperFunctions {
  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.deepOrange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen( Widget screen) {
    Navigator.push(
      Get.context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }  static void navigateAndReplaceScreen( Widget screen) {
    Navigator.pushReplacement(
      Get.context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context).size.width;
  }
  static Color getStatusColor(String status) {

    switch (status) {
      case 'accepted':
        return Color(0xff1AB095);
      case 'rejected':
        return Color(0xffF15178);
      default:
        return Colors.orange;
    }
  }

  static String getFormattedDate(DateTime? date, {String format = 'dd MMM yyyy'}) {
    if (date == null) {
      return '';
    }
    return DateFormat(format).format(date);
  }
 static int calAge(DateTime? dob) {
    if (dob == null) {
      return 0;
    }
    var currentDate = DateTime.now();
    var age = currentDate.year - dob.year;
    var month1 = currentDate.month;
    var month2 = dob.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      var day1 = currentDate.day;
      var day2 = dob.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

static getStateArabic(String status){
  switch(status){
    case 'accepted':
      return 'مقبول';
    case 'rejected':
      return 'مرفوض';
    default:
      return 'قيد الانتظار';
  }
}}




class NavigationHelper {
  // Navigate to a new screen
  static Future<T?> goTo<T>( Widget screen) {
    return Navigator.push(
      Get.context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Navigate to a new screen and replace the current screen
  static Future<T?> goToAndReplace<T>( Widget screen) {
    return Navigator.pushReplacement(
      Get.context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Navigate to a new screen and remove all previous screens
  static Future<T?> goToAndRemoveUntil<T>( Widget screen) {
    return Navigator.pushAndRemoveUntil(
      Get.context,
      MaterialPageRoute(builder: (context) => screen),
          (Route<dynamic> route) => false,
    );
  }

  // Navigate back to the previous screen
  static void goBack() {
    Navigator.pop( Get.context);
  }

  // Navigate back to the previous screen with result
  static void goBackWithResult<T>( T result) {
    Navigator.pop( Get.context, result);
  }

  // Check if can go back
  static bool canNavigateBack() {
    return Navigator.canPop( Get.context);
  }
}

// Example usage:
// NavigationHelper.goTo(context, NewScreen());
// NavigationHelper.goToAndReplace(context, NewScreen());
// NavigationHelper.goToAndRemoveUntil(context, NewScreen());
// NavigationHelper.goBack(context);
// NavigationHelper.goBackWithResult(context, result);

