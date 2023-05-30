extension DateLogic on DateTime {
  String differenceInDays() {
    final DateTime dateTimeNow = DateTime.now();
    final Duration diff = difference(dateTimeNow);
    return diff.inDays.toString();
  }
}
