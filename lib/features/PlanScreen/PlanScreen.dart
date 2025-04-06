



import 'package:flutter/material.dart';
import 'package:meditech/core/constants/colors.dart' show AppColors;

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
