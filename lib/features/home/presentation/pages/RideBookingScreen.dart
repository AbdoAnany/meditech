import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/colors.dart';

class RideBookingScreen extends StatefulWidget {
  const RideBookingScreen({Key? key}) : super(key: key);

  @override
  State<RideBookingScreen> createState() => _RideBookingScreenState();
}

class _RideBookingScreenState extends State<RideBookingScreen> {
  bool isRoundTrip = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.white,
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Align(
                  alignment: Alignment.topCenter,child:  Container(
                    height: 500.h,
                    child: Stack(
                      children: [
                        // MapScreenLocation(),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: MediaQuery.of(context).padding.top,),
                              Text(
                                'مرحبا عبدالله 👋 ',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.ibmPlexSansArabic(
                                  color: Color(0xFF1D2035),
                                  fontSize: 18.sp,
                                  // fontFamily: 'IBM Plex Sans Arabic',
                                  fontWeight: FontWeight.w700,
                                  // height: 0.08,
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                'وين حاب تسافر اليوم !',

                                textAlign: TextAlign.right,
                                style: GoogleFonts.ibmPlexSansArabic(
                                  color: Color(0xFF637D92),

                                  fontSize: 16.sp,
                                  // fontFamily: 'IBM Plex Sans Arabic',
                                  fontWeight: FontWeight.w500,
                                  //    height: 0.09,
                                ),
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              Container(
                                // width: 143.w,
                                height: 48.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 5.h),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.scan,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'تحقق من رحلة',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.ibmPlexSansArabic(
                                        color: Color(0xFF1D2035),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 0.10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              Container(
                                // width: 94,
                                height: 48,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 5.h),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.verified_user,
                                      color: Color(0xFF2770DC),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'الدعم',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.ibmPlexSansArabic(
                                        color: Color(0xFF1D2035),
                                        fontSize: 14,
                                        // fontFamily: 'IBM Plex Sans Arabic',
                                        fontWeight: FontWeight.w500,
                                        height: 0.10,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 464.h,
                      decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, -3),
                          )
                        ]
                      ),
                      child: TripPage()),
                ),


              ],
            ),
          ),
          // Container(
          //
          //   padding: EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //     border: Border(top: BorderSide(color: Colors.grey[300]!)),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       _BottomNavItem(
          //           icon: Iconsax.car,
          //           label: 'احجز الان',
          //           isSelected: true),
          //       _BottomNavItem(
          //           icon: Iconsax.calendar_add,
          //           label: 'الحجوزات',
          //           isSelected: false),
          //       _BottomNavItem(
          //           icon: Iconsax.notification_status,
          //           label: 'الإشعارات',
          //           isSelected: false),
          //       _BottomNavItem(
          //           icon: Icons.person_rounded,
          //           label: 'حسابي',
          //           isSelected: false),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class DropdownWidget extends StatefulWidget {
  final IconData icon;
  final String hint;
  final List<String> options;
  final Function(String) onOptionSelected;

  const DropdownWidget({
    Key? key,
    required this.icon,
    required this.hint,
    required this.options,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleDropdown,
      child: Container(
        height: 64.h,
        padding:  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFE7EBEF)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(widget.icon),
            const SizedBox(width: 10),
            Text(
              selectedOption ?? widget.hint,
              textAlign: TextAlign.center,
              style:  GoogleFonts.ibmPlexSansArabic(
                color: Color(0xFF4A5E6D),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(Iconsax.arrow_left_2, color: Colors.blueGrey),
          ],
        ),
      ),
    );
  }

  void _toggleDropdown() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                widget.hint,
                style:  GoogleFonts.ibmPlexSansArabic(
                  fontSize: 18.sp,
                  color: Color(0xFF151A51),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Divider(color: Color(0xffE7EBEF),),
            Flexible(
              child: ListView.builder(
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  final option = widget.options[index];
                  return ListTile(
                    title: Text(option),
                    onTap: () {
                      setState(() {
                        selectedOption = option;
                      });
                      widget.onOptionSelected(option);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DatePickerWidget extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function(DateTime) onDatePicked;

  const DatePickerWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onDatePicked,
  }) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDatePicker,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFE7EBEF)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(widget.icon),
            const SizedBox(width: 10),
            Text(
              _selectedDate != null
                  ? DateFormat('MMM d').format(_selectedDate!)
                  : widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF4A5E6D),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(Iconsax.arrow_left_2, color: Colors.blueGrey),
          ],
        ),
      ),
    );
  }

  void _showDatePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => Container(
        height: 900,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                widget.title??'',
                style:  TextStyle(
                  fontSize: 18.sp,
                  color: Color(0xFF151A51),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Divider(color: Color(0xffE7EBEF),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CalendarDatePicker(
                initialDate: (_selectedDate ?? DateTime.now()),
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
                onDateChanged: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                  widget.onDatePicked(date);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TripPage extends StatefulWidget {
  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  bool isRoundTrip = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Column(
        children: [
          TabBar(
            padding: EdgeInsets.symmetric(vertical: 19.h),
            labelStyle: GoogleFonts.ibmPlexSansArabic(
              color: AppColors.primary,
              fontSize: 16.sp,
              // fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.w700,
              height: 0.09,
            ),
            tabs: [
              Tab(text: 'ذهاب فقط'),
              Tab(
                text: 'ذهاب وعودة',
              ),
            ],
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 5,
            unselectedLabelStyle: GoogleFonts.ibmPlexSansArabic(
              color: Color(0xFF92A5B5),
              fontSize: 16.sp,

              fontWeight: FontWeight.w500,
              // height: 0.09,
            ),
            indicatorColor: AppColors.primary,
            onTap: (index) {
              print('index: $index');
              setState(() {
                isRoundTrip =
                    index == 1; // Switch between round trip and one-way
              });
              print('isRoundTrip: $isRoundTrip');
            },
          ),
          SizedBox(
            height: 368.h,
            child: TabBarView(
              children: [
                // One Way Trip Tab Content
                _TripTabContent(isRoundTrip:false  ),
                // Round Trip Tab Content
                _TripTabContent(isRoundTrip: true),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class _TripTabContent extends StatelessWidget {
  final bool isRoundTrip;

  const _TripTabContent({Key? key, required this.isRoundTrip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              children: [
                DropdownWidget(
                    icon: Iconsax.car,options:
                    ["الموصل","دمشق","بغداد"],
                    onOptionSelected: (option) {

                    },
                    hint: 'شنو محطة الذهاب ؟'),
                SizedBox(height: 12.h),
                DropdownWidget(icon: Iconsax.location,
                    options:
                    ['محطة الذهاب', 'محطة الوصول'],
                    onOptionSelected: (option) {

                    },
                    hint: 'محطة الوصول !'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                    child: DatePickerWidget(onDatePicked: (e){},
                        title: 'تاريخ الذهاب', icon: Iconsax.calendar_1)),


                if (isRoundTrip)SizedBox(width: 12),
                if (isRoundTrip) Expanded(
                    child: DatePickerWidget(onDatePicked: (e){},
                        title: 'تاريخ العودة', icon: Iconsax.calendar_1)),

              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 64.h,
            padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            margin:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
            decoration: ShapeDecoration(
              color: AppColors.primary ,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ابحث عن الرحلة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    //  fontFamily: 'IBM Plex Sans Arabic',
                    fontWeight: FontWeight.w700,
                    // height: 0.09,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Iconsax.search_normal_1,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
          )
          // Bottom navigation
        ],
      ),
    );
  }
}
