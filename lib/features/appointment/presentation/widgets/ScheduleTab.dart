import 'package:meditech/core/formatters/formatter.dart';
import 'package:meditech/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class DateTimeCard extends StatelessWidget {
  const DateTimeCard({
    Key? key,this.date,
    this.stateColor = 'pending',
  }) : super(key: key);
final DateTime? date;
final String stateColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:  THelperFunctions.getStatusColor(stateColor).withOpacity(.07),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color:  THelperFunctions.getStatusColor(stateColor),
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
               TFormatter.dateArabicFormat(date),
                style: TextStyle(
                  fontSize: 14,
                  color:  THelperFunctions.getStatusColor(stateColor),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: THelperFunctions.getStatusColor(stateColor),
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),

              Text(
    '5:00  - 11:00 مساءً',

                style: TextStyle(
                  color:THelperFunctions.getStatusColor(stateColor),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MyColors {
  static int header01 = 0xff151a56;
  static int primary = 0xff575de3;
  static int purple01 = 0xff918fa5;
  static int purple02 = 0xff6b6e97;
  static int yellow01 = 0xffeaa63b;
  static int yellow02 = 0xfff29b2b;
  static int bg = 0xfff5f3fe;
  static int bg01 = 0xff6f75e1;
  static int bg02 = 0xffc3c5f8;
  static int bg03 = 0xffe8eafe;
  static int text01 = 0xffbec2fc;
  static int grey01 = 0xffe9ebf0;
  static int grey02 = 0xff9796af;
}

TextStyle kTitleStyle = TextStyle(
  color: Color(MyColors.header01),
  fontWeight: FontWeight.bold,
);

TextStyle kFilterStyle = TextStyle(
  color: Color(MyColors.bg02),
  fontWeight: FontWeight.w500,
);