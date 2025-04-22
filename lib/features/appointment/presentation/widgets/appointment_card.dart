
import 'dart:convert';
import 'package:meditech/core/Enums.dart';
import 'package:meditech/core/constants/Global.dart';
import 'package:meditech/core/helpers/helper_functions.dart';
import 'package:meditech/core/style/app_color.dart';
import 'package:meditech/features/appointment/data/models/appointment.dart';
import 'package:meditech/features/appointment/data/repositories/appointment_repository.dart';
import 'package:meditech/features/1-login/presentation/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/colors.dart';
import 'ScheduleTab.dart';
import '../pages/appoinment_screen.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final AppointmentRepository _appointmentRepository = AppointmentRepository();

  AppointmentCard({Key? key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 8),
          if (appointment.status == 'rejected') _buildRejectionReason(),
          if (appointment.visitDateTime != null) _buildDateTimeCard(),
          if (Global.userDate?.userType != UserRole.patient.name) _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(),
        const SizedBox(width: 8),
        Expanded(
          child: Text(appointment.patientName ?? 'No Name', style: GoogleFonts.ibmPlexSansArabic(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 8),
        _buildStatusChip(),
      ],
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColor.grey.withOpacity(.1),
      child: const Icon(Iconsax.user, color: AppColor.grey, size: 24),
    );
  }

  Widget _buildStatusChip() {
    final stateColor = THelperFunctions.getStatusColor(appointment.status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(color: stateColor.withOpacity(.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: stateColor, width: 0.5)),
      child: Text(THelperFunctions.getStateArabic(appointment.status), style: GoogleFonts.ibmPlexSansArabic(color: stateColor, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildRejectionReason() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Text("سبب الرفض: ${appointment.rejectionReason}", style: GoogleFonts.ibmPlexSansArabic(color: THelperFunctions.getStatusColor(appointment.status), fontSize: 14)),
    );
  }

  Widget _buildDateTimeCard() {
    return DateTimeCard(date: appointment.visitDateTime!, stateColor: appointment.status);
  }

  Widget _buildActionButtons(BuildContext context) {
    final bool isAccepted = appointment.status == 'accepted';
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: _buildAcceptButton(context, isAccepted)),
          const SizedBox(width: 8),
          Expanded(child: _buildRejectButton(context)),
        ],
      ),
    );
  }

  Widget _buildAcceptButton(BuildContext context, bool isAccepted) {
    return MaterialButton(
      onPressed: () => _showAcceptOrderDialog(context),
      color: isAccepted ? THelperFunctions.getStatusColor('pending') :
      THelperFunctions.getStatusColor('accepted'),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Text(isAccepted ? 'جدولة' : 'قبول', style: GoogleFonts.ibmPlexSansArabic(color: AppColor.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildRejectButton(BuildContext context) {
    final rejectColor = THelperFunctions.getStatusColor('rejected');
    return MaterialButton(
      onPressed: () => _showRejectDialog(context),
      color: rejectColor.withOpacity(.1),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Text("رفض", style: GoogleFonts.ibmPlexSansArabic(color: rejectColor, fontWeight: FontWeight.bold)),
    );
  }

  Future<void> _showAcceptOrderDialog(BuildContext context) async {
    DateTime? selectedDate;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAcceptAppointmentSheet(context, selectedDate),
    );
  }

  Widget _buildAcceptAppointmentSheet(BuildContext context, DateTime? selectedDate) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('قبول الموعد', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
              SizedBox(
                height: 300,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  itemExtent: 70,
                  minimumDate: DateTime.now(),
                  maximumDate: DateTime.now().add(const Duration(days: 189)),
                  onDateTimeChanged: (newDateTime) {
                    setState(() {
                      selectedDate = newDateTime;
                    });
                  },
                ),
              ),
              SizedBox(height: 8.h),
              _buildAcceptAppointmentButtons(context, selectedDate),
              SizedBox(height: 64.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAcceptAppointmentButtons(BuildContext context, DateTime? selectedDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء', style: TextStyle(color: Colors.red))),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () => _handleAcceptAppointment(context, selectedDate),
          child: const Text('تأكيد', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Future<void> _handleAcceptAppointment(BuildContext context, DateTime? selectedDate) async {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى تحديد تاريخ ووقت')));
      return;
    }
    await _updateOrderStatus(appointment.id, 'accepted', visitDateTime: selectedDate);
    await _sendAcceptedAppointmentNotification();
    Navigator.pop(context);
  }

  Future<void> _sendAcceptedAppointmentNotification() async {
    await sendNotification(
      title: 'Accepted Appointment',
      message: 'Your appointment has been accepted.',
      topic: "patients_topic_${Global.userDate?.phone}",
      registrationTokens: appointment.token,
      data: appointment.toMap(),
    );
    await _sendNotification(
      title: 'Accepted Appointment',
      body: 'Your appointment has been accepted.',
      type: 'accepted_appointment',
      topic: "patients_topic_${Global.userDate?.phone}",
    );
  }

  Future<void> _showRejectDialog(BuildContext context) async {
    final rejectReasonController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildRejectAppointmentSheet(context, rejectReasonController),
    );
  }

  Widget _buildRejectAppointmentSheet(BuildContext context, TextEditingController rejectReasonController) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('رفض الموعد', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 16.h),
          CustomTextField(controller: rejectReasonController, hintText: 'سبب الرفض'),
          SizedBox(height: 32.h),
          _buildRejectAppointmentButtons(context, rejectReasonController),
          SizedBox(height: 64.h),
        ],
      ),
    );
  }

  Widget _buildRejectAppointmentButtons(BuildContext context, TextEditingController rejectReasonController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء', style: TextStyle(color: Colors.red))),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () => _handleRejectAppointment(context, rejectReasonController),
          child: const Text('حفظ', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Future<void> _handleRejectAppointment(BuildContext context, TextEditingController rejectReasonController) async {
    final reason = rejectReasonController.text.trim();
    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى إدخال سبب الرفض')));
      return;
    }
    await _updateOrderStatus(appointment.id, 'rejected', rejectionReason: reason);
    await _sendRejectedAppointmentNotification(reason);
    Navigator.pop(context);
  }

  Future<void> _sendRejectedAppointmentNotification(String reason) async {
    await _sendNotification(
      title: 'Rejected Appointment',
      body: 'Your appointment has been rejected because $reason.',
      type: 'rejected_appointment',
      topic: "patients_topic_${Global.userDate?.phone}",
    );
  }

  Future<void> _updateOrderStatus(String orderId, String status, {String? note, String? rejectionReason, DateTime? visitDateTime}) async {
    try {
      await _appointmentRepository.updateAppointmentStatus(orderId, status, note: note, rejectionReason: rejectionReason, visitDateTime: visitDateTime);
    } catch (e) {
      debugPrint("Error updating order status: $e");
    }
  }

  Future<void> _sendNotification({required String title, required String body, required String type, required String topic}) async {
    try {
      final notificationPayload = {
        'to': '/topics/$topic',
        'notification': {'title': title, 'body': body},
        'data': {'type': type, 'appointmentId': appointment.id},
      };
      final response = await http.post(
        Uri.parse('https://abdoanany.pythonanywhere.com/pushFCM'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(notificationPayload),
      );
      if (response.statusCode == 200) {
        debugPrint('Notification sent successfully.');
      } else {
        debugPrint('Failed to send notification. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }
  }
}

class AppointmentCardHistory extends StatelessWidget {
  const AppointmentCardHistory({super.key, required this.appointment});
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final bool isAccepted = appointment.status == 'accepted';
    final bool isRejected = appointment.status == 'rejected';
    final stateColor = THelperFunctions.getStatusColor(appointment.status);
print( appointment.toMap());
      return Container(
        // margin: EdgeInsets.only(bottom: 6.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.05),
          //     blurRadius: 6,
          //     offset: const Offset(0, 12),
          //   ),
          // ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                   ( appointment.patientName!.isEmpty?"NA":appointment.patientName  ??'NA ').substring(0, 1),
                    style: GoogleFonts.ibmPlexSansArabic(
                      color: AppColors.primary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.patientName ?? 'No Name',
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: const Color(0xFF1D2035),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      appointment.description,
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: Colors.grey.shade700,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    if(!isAccepted&&!isRejected)
                    Row(
                      children: [
                        Icon(
                          Iconsax.calendar,
                          size: 14.sp,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _formatDate(appointment.timestamp!),
                          style: GoogleFonts.ibmPlexSansArabic(
                            color: Colors.grey.shade600,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Icon(
                          Iconsax.clock,
                          size: 14.sp,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _formatTime(appointment.timestamp!),
                          style: GoogleFonts.ibmPlexSansArabic(
                            color: Colors.grey.shade600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    if(isAccepted)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'موعد الزيارة',
                          style: GoogleFonts.ibmPlexSansArabic(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Icon(
                          Iconsax.calendar,
                          size: 14.sp,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _formatDate(appointment.visitDateTime!),
                          style: GoogleFonts.ibmPlexSansArabic(
                            color: Colors.grey.shade600,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Icon(
                          Iconsax.clock,
                          size: 14.sp,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _formatTime(appointment.visitDateTime!),
                          style: GoogleFonts.ibmPlexSansArabic(
                            color: Colors.grey.shade600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    if(isRejected)
                      Text(
                        'سبب الرفض: ${appointment.rejectionReason}',
                        style: GoogleFonts.ibmPlexSansArabic(
                          color: Colors.red,
                          fontSize: 12.sp,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: stateColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  isAccepted ? 'مؤكد' : 'بانتظار التأكيد',
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: stateColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            ],
          ),
        ),
      );


  }
  String _formatDate(DateTime? date) {
    if (date == null) {
      return "__/__/____";
    }
    return "${date.day}/${date.month}/${date.year}";
  }
  String _formatTime(DateTime? date) {
    if (date == null) {
      return "__:__";
    }
    return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

}
