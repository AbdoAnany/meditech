import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meditech/features/appointment/data/models/appointment.dart';
import 'package:meditech/features/appointment/data/repositories/appointment_repository.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepository _appointmentRepository;
  StreamSubscription? _adminSubscription;
  StreamSubscription? _userSubscription;

  AppointmentCubit(this._appointmentRepository) : super(AppointmentInitial());

  @override
  Future<void> close() {
    _adminSubscription?.cancel();
    _userSubscription?.cancel();
    return super.close();
  }

  void fetchAdminAppointments() {
    _emitLoadingState();
    _adminSubscription = _appointmentRepository.getAdminAppointmentsStream().listen(
      _handleAppointmentsLoaded,
      onError: _handleError,
    );
  }

  void fetchUserAppointments(String userId) {
    _emitLoadingState();
    _userSubscription = _appointmentRepository.getUserAppointmentsStream(userId: userId).listen(
      _handleAppointmentsLoaded,
      onError: _handleError,
    );
  }

  Future<void> createAppointment(Appointment appointment) async {
    try {
      await _appointmentRepository.createAppointment(appointment);
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  Future<void> updateAppointmentStatus(
      String appointmentId,
      String status, {
        String? note,
        String? rejectionReason,
        DateTime? visitDateTime,
      }) async {
    try {
      await _appointmentRepository.updateAppointmentStatus(
        appointmentId,
        status,
        note: note,
        rejectionReason: rejectionReason,
        visitDateTime: visitDateTime,
      );
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  void _emitLoadingState() {
    _adminSubscription?.cancel();
    _userSubscription?.cancel();
    emit(AppointmentLoading());
  }

  void _handleAppointmentsLoaded(List<Appointment>? appointments) {
    emit(AppointmentLoaded(appointments));
  }

  void _handleError(Object error) {
    emit(AppointmentError(error.toString()));
  }
}
