import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneService {
  static Future<void> initialize() async {
    tzdata.initializeTimeZones();
    final String timeZone = await _getDeviceTimeZone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  static Future<String> _getDeviceTimeZone() async {
    try {
      // First try to get the timezone from the device
      final timezone = DateTime.now().timeZoneName;
      return timezone;
    } catch (e) {
      // Fallback to a default timezone if device timezone is not available
      return 'UTC';
    }
  }

  static tz.TZDateTime convertToTZ(DateTime dateTime) {
    return tz.TZDateTime.from(dateTime, tz.local);
  }
}