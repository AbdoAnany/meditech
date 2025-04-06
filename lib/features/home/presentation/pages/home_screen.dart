
import 'package:meditech/features/appointment/presentation/pages/appoinment_screen.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/Global.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../profile/presentation/pages/ProfileScreen.dart';
import 'DoctorHomeScreen.dart';
import '../../../notification/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,

        statusBarColor: Colors.transparent, // Makes the status bar transparent
        statusBarIconBrightness: Brightness
            .dark, // Adjusts icon brightness (light for dark backgrounds)
      ),
    );
    super.initState();
  }

  int _currentIndex = 0;
  final List<Widget> _screens = [
    // MainScreen(),
    DoctorHomeScreen(),
    // ServicesScreen(),
    AppointmentsScreen(),
    //  AppointmentsScreen(
    //   userType: UserRole.doctor,
    // ),
    WeightLossPlanScreen(),
    // NotificationScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.scaffoldBackgroundColor,
          body: _screens[_currentIndex],
          bottomNavigationBar: SizedBox(
            height: 75.h,
            child: BottomNavigationBar(
              backgroundColor: AppColors.scaffoldBackgroundColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              elevation: 0,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.textSecondary,
              selectedLabelStyle: GoogleFonts.ibmPlexSansArabic(
                color: AppColors.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
              iconSize: 30.sp,
              unselectedLabelStyle: GoogleFonts.ibmPlexSansArabic(
                color: AppColors.textSecondary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.home),
                  label: 'احجز الان',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon( Iconsax.home),
                //   label: 'احجز الان',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.calendar_add),
                  label: 'الحجوزات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.routing_2),
                  label: 'البرامج',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Iconsax.notification_status),
                //   label: 'الإشعارات',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.user),
                  label: 'حسابي',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProgramsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 70.h,
        title: Text(
          "البرامج",
          style: GoogleFonts.ibmPlexSansArabic(
              color: Colors.black, fontSize: 18.sp),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.routing_2,
              color: Color(0xffEBEBEB),
              size: 150.sp,
            ),
            SizedBox(height: 20.h),
            Text(
              "ما فيش برامج جديدة!",
              style: GoogleFonts.ibmPlexSansArabic(
                  color: Color(0xFF2B2F4E),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "تابعنا هنا عشان ماتفوتش أي حاجة مهمة",
              style: GoogleFonts.ibmPlexSansArabic(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff637D92),
                  fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class WeightLossPlanScreen extends StatefulWidget {
  static const String route = "/WeightLossPlanScreen";

  @override
  _WeightLossPlanScreenState createState() => _WeightLossPlanScreenState();
}

class _WeightLossPlanScreenState extends State<WeightLossPlanScreen> {
  int _currentStep = 0; // Tracks the current week

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // SizedBox(height: MediaQuery.of(context).padding.top + (0.05 * MediaQuery.of(context).size.height)),
          Expanded(
            child: Stepper(
              connectorColor: WidgetStateProperty.all(AppColors.primary),
              physics: ClampingScrollPhysics(),
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep < 2) {
                  setState(() {
                    _currentStep++;
                  });
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep--;
                  });
                }
              },
              steps: [
                _buildWeekStep(
                    0,
                    "الأسبوع 1-4: المرحلة الأولى (التعافي والتكيف)",
                    _week1to4Plan()),
                _buildWeekStep(
                    1,
                    "الأسبوع 5-8: المرحلة الثانية (تعزيز فقدان الوزن)",
                    _week5to8Plan()),
                _buildWeekStep(
                    2,
                    "الأسبوع 9-12: المرحلة الثالثة (الحفاظ على الوزن)",
                    _week9to12Plan()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Step _buildWeekStep(int index, String title, Widget content) {
    return Step(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: _currentStep == index ? AppColors.primary : Colors.grey,
        ),
      ),
      content: content,
      isActive: _currentStep == index,
      state: _currentStep > index ? StepState.complete : StepState.indexed,
    );
  }

  Widget _week1to4Plan() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDayPlan("السبت", "سوائل صافية (مرق، ماء، شاي أعشاب)",
              "المشي 5-10 دقائق", "تجنب المشروبات الغازية والسكرية"),
          _buildDayPlan("الأحد", "سوائل صافية + عصير تفاح مخفف",
              "المشي 10 دقائق", "تناول السوائل ببطء وبكميات صغيرة"),
          _buildDayPlan("الإثنين", "سوائل كاملة (حساء خفيف، عصائر)",
              "المشي 10-15 دقائق", "تجنب الأطعمة الصلبة"),
          _buildDayPlan("الثلاثاء", "سوائل كاملة + زبادي قليل الدسم",
              "المشي 15 دقائق", "اشرب الماء بين الوجبات"),
          _buildDayPlan("الأربعاء", "أطعمة مهروسة (بطاطس، شوربة خضار)",
              "المشي 15 دقائق", "امضغ الطعام جيداً"),
          _buildDayPlan("الخميس", "أطعمة مهروسة + بيض مسلوق مهروس",
              "المشي 20 دقائق", "تجنب السكريات والدهون"),
          _buildDayPlan("الجمعة", "أطعمة لينة (سمك مطهو، جبن قليل الدسم)",
              "المشي 20 دقائق", "استشر طبيبك قبل إدخال أطعمة جديدة"),
        ],
      ),
    );
  }

  Widget _week5to8Plan() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDayPlan("السبت", "زبادي مع فواكه مهروسة", "المشي 25 دقيقة",
              "تناول البروتين أولاً"),
          _buildDayPlan("الأحد", "بيض مسلوق مع خضار",
              "تمارين إطالة + مشي 20 دقيقة", "تجنب الأطعمة المقلية"),
          _buildDayPlan("الإثنين", "شوفان مع حليب قليل الدسم", "المشي 30 دقيقة",
              "اشرب 8 أكواب ماء يومياً"),
          _buildDayPlan("الثلاثاء", "جبن قليل الدسم مع خيار",
              "تمارين مقاومة خفيفة", "تجنب الكافيين"),
          _buildDayPlan("الأربعاء", "عصير أخضر (سبانخ، تفاح، زنجبيل)",
              "المشي 30 دقيقة", "تناول وجبات صغيرة كل 3-4 ساعات"),
          _buildDayPlan("الخميس", "بيض أومليت مع خضار",
              "تمارين إطالة + مشي 25 دقيقة", "تجنب الدهون غير الصحية"),
          _buildDayPlan("الجمعة", "زبادي مع فواكه", "المشي 30 دقيقة",
              "راقب كمية الطعام المتناولة"),
        ],
      ),
    );
  }

  Widget _week9to12Plan() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDayPlan("السبت", "شوفان مع حليب قليل الدسم",
              "تمارين مقاومة + مشي 30 دقيقة", "تناول البروتين في كل وجبة"),
          _buildDayPlan("الأحد", "بيض مسلوق مع خضار",
              "تمارين إطالة + مشي 35 دقيقة", "تجنب الأطعمة المصنعة"),
          _buildDayPlan("الإثنين", "زبادي مع فواكه",
              "تمارين كارديو (دراجة ثابتة)", "اشرب الماء بانتظام"),
          _buildDayPlan("الثلاثاء", "عصير أخضر", "تمارين مقاومة + مشي 30 دقيقة",
              "تجنب السكريات المضافة"),
          _buildDayPlan("الأربعاء", "جبن قليل الدسم مع خيار",
              "تمارين إطالة + مشي 35 دقيقة", "تناول وجبات صغيرة ومتكررة"),
          _buildDayPlan("الخميس", "بيض أومليت مع خضار",
              "تمارين كارديو + مشي 30 دقيقة", "تجنب الأطعمة المقلية"),
          _buildDayPlan("الجمعة", "زبادي مع فواكه",
              "تمارين مقاومة + مشي 40 دقيقة", "راقب الوزن باستمرار"),
        ],
      ),
    );
  }

  Widget _buildDayPlan(String day, String diet, String exercise, String tips) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                day,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.restaurant_menu, "النظام الغذائي", diet),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.fitness_center, "التمارين", exercise),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.lightbulb_outline, "نصائح", tips),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ServiceIcon extends StatelessWidget {
  final String icon;
  final String label;

  ServiceIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset(
            icon.toString(),
            color: AppColors.primary,
          ),
          radius: 20,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
              fontSize: 14.w,
              color: AppColors.primary,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class LabCard extends StatelessWidget {
  final String image;
  final String? imageAvater;
  final String name;
  final double rating;
  final String distance;

  LabCard({
    required this.image,
    this.imageAvater,
    required this.name,
    required this.rating,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.91.w,
      height: 220.h,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image,
              width: double.infinity, height: 150.h, fit: BoxFit.cover),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(imageAvater!,
                    width: 40.w, height: 40.w, fit: BoxFit.cover),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(name.tr(),
                            style: TextStyle(
                                fontSize: 16.w, fontWeight: FontWeight.bold)),
                        SizedBox(width: 4.w),
                        Padding(
                          padding: EdgeInsets.only(top: 6.0.h),
                          child: Text(rating.toString(),
                              style: TextStyle(
                                  fontSize: 14.w,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Icon(Icons.star, color: Colors.amber, size: 16.w),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 8.w),
                        Text(distance.tr(),
                            style:
                                TextStyle(fontSize: 14.w, color: Colors.grey)),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}

class ServicesScreen1 extends StatelessWidget {
  final List<Map<String, String>> surgeries = [
    {
      'title': 'عملية الساسي',
      'description': 'عملية الساسي من العمليات الجراحية التي...',
      'image':
          'https://www.meditech.com/images/services/%D8%AA%D9%83%D9%85%D9%8A%D9%85%20%D8%A7%D9%84%D9%85%D8%B9%D8%AF%D8%A9.jpg.webp',
    },
    {
      'title': 'عملية تحويل المسار المصغر',
      'description': 'عملية تحويل المسار مناسبة للأشخاص...',
      'image':
          'https://www.meditech.com/images/services/%D8%B9%D9%85%D9%84%D9%8A%D8%A9%20%D8%AA%D8%AD%D9%88%D9%8A%D9%84%20%D8%A7%D9%84%D9%85%D8%B3%D8%A7%D8%B1%20%D8%A7%D9%84%D9%85%D8%B5%D8%BA%D8%B1.png.webp',
    },
    {
      'title': 'عملية تكميم المعدة',
      'description': 'هي أكبر عمليات السمنة انتشارًا...',
      'image':
          'https://www.meditech.com/images/services/%D8%B9%D9%85%D9%84%D9%8A%D8%A9%20%D8%A7%D9%84%D8%B3%D8%A7%D8%B3%D9%8A.jpg.webp',
    },
    {
      'title': 'عمليات تصحيح',
      'description': 'عمليات التصحيح تتم في حالة فشل جراحات السمنة...',
      'image':
          'https://www.meditech.com/images/services/%D8%B9%D9%85%D9%84%D9%8A%D8%A9-%D8%A7%D9%84%D8%A8%D8%A7%D9%84%D9%88%D9%86-%D9%84%D9%84%D9%85%D8%B9%D8%AF%D8%A9.jpg.webp',
    },
    {
      'title': 'الكبسولة الذكية',
      'description': 'الكبسولة الذكية الحل الأمثل بدون جراحة...',
      'image':
          'https://www.meditech.com/images/services/%D8%A7%D9%84%D9%83%D8%A8%D8%B3%D9%88%D9%84%D8%A9%20%D8%A7%D9%84%D8%B0%D9%83%D9%8A%D8%A9.jpg.webp',
    },
    {
      'title': 'بالون المعدة وأنواعه',
      'description': 'بالون المعدة مناسب للأشخاص...',
      'image':
          'https://www.meditech.com/images/services/%D8%AA%D8%B5%D8%AD%D9%8A%D8%AD.png.webp',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('العمليات الجراحية',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // عدد الأعمدة
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.7, // نسبة الطول إلى العرض
          ),
          itemCount: surgeries.length,
          itemBuilder: (context, index) {
            return SurgeryCard(
              title: surgeries[index]['title']!,
              description: surgeries[index]['description']!,
              imagePath: surgeries[index]['image']!,
            );
          },
        ),
      ),
    );
  }
}

class SurgeryCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const SurgeryCard({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      // height: 100.h,
      // width: MediaQuery.of(context).size.width / 4.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            child: Text(title,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey)),
          ),
          Spacer(),
          MaterialButton(
            height: 48.h,
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            onPressed: () {},
            color: AppColors.primary,
            textColor: Colors.white,
            child: Text('احجز الان'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الخدمات'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('جراحات السمنة المفرطة'),
            _buildServiceList([
              'عملية تكميم المعدة',
              'تكميم المعدة المثبت المقوى',
              'التكميم البكيني',
              'التكميم الدقيق',
              'التكميم الثلاثي',
              'التكميم المعدل',
              'تحويل المســار المصغـر',
              'تحويل المسار الكلاسيكي',
              'عملية الساسي',
              'بالون المعدة',
              'الكبسولة الذكية',
              'إصلاح عمليات السمنة الفاشلة',
            ]),
            SizedBox(height: 24.0),
            _buildSectionTitle('جراحات التجميل وتنسيق القوام'),
            _buildServiceList([
              'شفـط الدهون بالفيزر',
              'شـــد البــطن',
              'علاج التثدي',
              'تنسيق القوام',
              'نحت الجســم',
              'شد ترهلات الجسم',
              'اصلاح عضلات البطن',
            ]),
            SizedBox(height: 24.0),
            _buildSectionTitle('عمليات الجلدية'),
            _buildServiceList([
              'جلسات استعادة نضارة البشرة',
              'جلسات علاج تساقط الشعر',
              'علاج التجاعيد وشد الوجه',
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildServiceList(List<String> services) {
    return Wrap(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: services.map((service) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xffD8E8E8), width: 0.5),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          margin: EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            service,
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
        );
      }).toList(),
    );
  }
}
