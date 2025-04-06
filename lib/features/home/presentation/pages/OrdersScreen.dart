import 'package:flutter/material.dart';

// Custom colors
class AppColorss {
  static const primary = Color(0xFF4CAF50);
  static const secondary = Color(0xFFE8F5E9);
  static const textDark = Color(0xFF212121);
  static const textLight = Color(0xFF757575);
}

// Custom text styles
class AppTextStyles {
  static const heading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColorss.textDark,
  );
  static const body = TextStyle(
    fontSize: 14,
    color: AppColorss.textLight,
  );
}

// Navigation Item Widget
class NavigationItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const NavigationItem({
    Key? key,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? AppColorss.secondary : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? AppColorss.primary : AppColorss.textLight,
          ),
          const SizedBox(width: 12),
          Text(
            'Home',
            style: TextStyle(
              color: isSelected ? AppColorss.primary : AppColorss.textLight,
            ),
          ),
        ],
      ),
    );
  }
}

// Disease Card Widget
class DiseaseCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;

  const DiseaseCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: backgroundColor,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Pill Task Widget
class PillTaskItem extends StatelessWidget {
  final String medicineName;
  final String time;
  final bool isDone;
  final VoidCallback onTap;

  const PillTaskItem({
    Key? key,
    required this.medicineName,
    required this.time,
    this.isDone = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColorss.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.medication, color: AppColorss.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicineName,
                  style: AppTextStyles.heading,
                ),
                Text(
                  time,
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
          Checkbox(
            value: isDone,
            onChanged: (_) => onTap(),
            activeColor: AppColorss.primary,
          ),
        ],
      ),
    );
  }
}

// Custom Button Widget
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColorss.primary : Colors.white,
        foregroundColor: isPrimary ? Colors.white : AppColorss.primary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isPrimary ? Colors.transparent : AppColorss.primary,
          ),
        ),
      ),
      child: Text(label),
    );
  }
}

// Doctor Card Widget
class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final VoidCallback onTap;

  const DoctorCard({
    Key? key,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.heading,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      specialty,
                      style: AppTextStyles.body,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: AppTextStyles.body,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


