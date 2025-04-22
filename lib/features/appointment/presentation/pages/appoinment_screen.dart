
import 'dart:convert';
import 'dart:math';
import 'package:meditech/core/Enums.dart';
import 'package:meditech/core/notification_service/TokenMonitor.dart';
import 'package:meditech/features/appointment/data/models/appointment.dart';
import 'package:meditech/features/appointment/presentation/manager/appointment_cubit.dart';
import 'package:meditech/features/appointment/presentation/widgets/appointment_card.dart';
import 'package:meditech/features/1-login/presentation/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../../../../core/constants/Global.dart';
import '../../../../core/constants/colors.dart';
import '../../../../di.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppointmentCubit>(
      create: (context) => get_it<AppointmentCubit>()..fetchAppointments(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildTabContent(context),
          // floatingActionButton: _buildFloatingActionButton(context),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        _buildFloatingActionButton(context),
      ],
      title: const Text(
        "الحجوزات",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 4,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          // رجوع للخلف - عدل حسب التنقل
          // Navigator.pop(context);
        },
      ),
      bottom: const TabBar(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        indicatorColor: Colors.blue, // أو حسب لون التطبيق
        indicatorWeight: 3,
        tabs: [
          Tab(text: "قيد المراجعة"),
          Tab(text: "المقبول"),
          Tab(text: "المرفوض"),
        ],
      ),
    );
  }


  Widget _buildTabContent(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AppointmentLoaded) {
          return _buildAppointmentTabs(state.appointments??[]);
        } else if (state is AppointmentError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text("Unknown state"));
      },
    );
  }

  Widget _buildAppointmentTabs(List<Appointment> appointments) {
    return TabBarView(
      children: [
        _buildAppointmentsList(appointments, filter: 'pending'),
        _buildAppointmentsList(appointments, filter: 'accepted'),
        _buildAppointmentsList(appointments, filter: 'rejected'),
      ],
    );
  }

  Widget _buildAppointmentsList(List<Appointment> appointments, {String? filter}) {
    final filteredAppointments = appointments.where((a) => a.status == filter).toList();
    if (filteredAppointments.isEmpty) {
      return const Center(child: Text("لا توجد مواعيد حالياً"));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: filteredAppointments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) =>
          Global.userDate?.userType == UserRole.doctor.name ? AppointmentCard(appointment: filteredAppointments[index]) :
          AppointmentCardHistory(appointment: filteredAppointments[index]),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        elevation: 0,


        onPressed: () => _showAddAppointmentDialog(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),


        // child: const Icon(Icons.add, color: Colors.white),
        color: AppColors.transparent,
        child: const Text("حجز موعد ", style: TextStyle(color: AppColors.primary)),
      ),
    );
  }

  Future<void> _showAddAppointmentDialog(BuildContext context) async {
    final notesController = TextEditingController();
    DateTime? selectedDate /**/;
    final user = await Global.userDate;
    final appointmentCubit = get_it<AppointmentCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAddAppointmentSheet(context, notesController, selectedDate, user, appointmentCubit),
    );
  }

  Widget _buildAddAppointmentSheet(BuildContext context, TextEditingController notesController, DateTime? selectedDate, dynamic user, AppointmentCubit appointmentCubit) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('حجز موعد جديد', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 16.h),
          SizedBox(
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              itemExtent: 70,
              initialDateTime: selectedDate,
              minimumDate: DateTime.now(),
              maximumDate: DateTime.now().add(const Duration(days: 189)),
              onDateTimeChanged: (DateTime newDate) {
                selectedDate = newDate;
              },
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(controller: notesController, hintText: 'ملاحظات'),
          SizedBox(height: 32.h),
          _buildAddAppointmentButtons(context, notesController, selectedDate, user, appointmentCubit),
          SizedBox(height: 64.h),
        ],
      ),
    );
  }

  Widget _buildAddAppointmentButtons(BuildContext context, TextEditingController notesController, DateTime? selectedDate, dynamic user, AppointmentCubit appointmentCubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء', style: TextStyle(color: Colors.red))),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () async {
            final newAppointment = Appointment(
              userId: user!.phone,
              patientName: user.fullName,
              doctorId: 'doctorId',
              token: TokenMonitor.token ?? '',
              appointmentType: 'appointmentType',
              description: notesController.text,
              visitDateTime: selectedDate,
              rejectionReason: '',
              comments: [],
              id: Random().nextInt(10000).toString(),
              timestamp: DateTime.now(),
              status: AppointmentStatus.pending.name,
              notes: notesController.text,
            );
            await appointmentCubit.createAppointment(newAppointment);
            Navigator.pop(context);
            await _sendNewAppointmentNotification(user.fullName, newAppointment.id);
          },
          child: const Text('حجز', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Future<void> _sendNewAppointmentNotification(String userName, String appointmentId) async {
    await sendNotification(
      title: 'New Appointment',
      message: '$userName has booked an appointment.',
      registrationTokens: TokenMonitor.token,
      topic: 'doctors_topic',
      data: {'type': 'new_appointment', 'appointmentId': appointmentId},
    );
  }
}

Future<void> sendNotification({
  required String title,
  required String message,
  required dynamic registrationTokens,
  required Map<String, dynamic> data,
  String? topic,
}) async {
  final List<String> tokens = registrationTokens is String
      ? [registrationTokens]
      : List<String>.from(registrationTokens);

  final response = await http.post(
    //   amirc2.pythonanywhere.com
    //  Uri.parse('https://abdoanany.pythonanywhere.com/pushFCM'),
    Uri.parse('https://abdoanany.pythonanywhere.com/pushFCM'),
    body: json.encode({
      'title': title,
      'msg': message,
      // 'token': tokens.first,
      'data': data,
      'topic': topic ?? '',
    }),
    headers: {'Content-Type': 'application/json'},
  );
  print('sendNotification response ${response.body}');

  if (response.statusCode != 200) {
    throw Exception('Failed to send notification: ${response.statusCode}');
  }
}

// You might also need this helper widget
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: Theme.of(context).primaryColor),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

