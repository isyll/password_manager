enum Greeting {
  morning,
  afternoon,
  evening,
  night,
}

class GreetingUtils {
  /// Returns the appropriate Greeting enum based on the time of day
  static Greeting getGreeting({DateTime? time}) {
    final now = time ?? DateTime.now();
    final hour = now.hour;

    if (hour < 12) {
      return Greeting.morning;
    }
    return Greeting.evening;
  }
}
