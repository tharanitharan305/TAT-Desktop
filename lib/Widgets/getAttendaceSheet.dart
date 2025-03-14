class AttendanceSheet {
  Map<String, bool> getAttendanceSheet(int month, int year) {
    var maxArr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (year % 4 == 0) {
      maxArr = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    }
    int max = maxArr[month - 1];
    Map<String, bool> sheet = {};
    for (int i = 1; i <= max; i++) {
      sheet.putIfAbsent(i.toString(), () => false);
    }
    return sheet;
  }
}
