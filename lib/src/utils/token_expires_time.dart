class TokenExpiresInTime {
  static int currentDate, currentMinute;

  void getCurrentTimeInMinute() {
    DateTime time = new DateTime.now();
    time = time.toLocal();
    time = new DateTime(time.year, time.month, time.day, time.hour, time.minute,
        time.second, time.millisecond, time.microsecond);
    int date = int.parse(time.toString().substring(8, 10));
    int hour = int.parse(time.toString().substring(11, 13));
    int minute = int.parse(time.toString().substring(14, 16));

    // print(time);
    // print(date);
    // print(hour);
    // print(minute);
    // print(hour * 60 + minute);

    currentDate = date;
    currentMinute = hour * 60 + minute;
  }
}
