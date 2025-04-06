part of 'appointment_cubit.dart';


abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final List<Appointment>? appointments;

  AppointmentLoaded(this.appointments);
}

class AppointmentError extends AppointmentState {
  final String message;

  AppointmentError(this.message);
}
