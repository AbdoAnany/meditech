import '../../../../core/constants/image_strings.dart';
import 'OnBoardingInfo.dart';

class OnBoardingItems {
  List<OnBoardingInfo> items = [
    OnBoardingInfo(
      title: "فريق طبي متكامل",
      descriptions:
          'بشهادة عملاءنا، فريقنا الطبي يقوم على رعاية شاملة ومستمرة قبل وأثناء وبعد العملية بما يضمن راحتك التامة.',
      image: AppImages.onBoarding1,
      line: AppImages.onBoarding1,
    ),
    OnBoardingInfo(
      title: 'المتابعة المستمرة',
      descriptions:
          'دائماً متواجدون للرد على كافة استفساراتك والمتابعة الشخصية من دكتور عبد الرازق محمد.',
      image: AppImages.onBoarding2,
      line: AppImages.onBoarding2,
    ),
    OnBoardingInfo(
      title: 'إقامة فندقية',
      descriptions:
          'يضمن لك مركز دكتور عبد الرازق محمد أفضل المستشفيات للعملية والحصول على رعاية كاملة وراحة تامة قبل وأثناء وبعد العملية.',
      line: AppImages.onBoarding3,
      image: AppImages.onBoarding3,
    ),
  ];
}
