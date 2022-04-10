bool compareDateTimeWithoutHours(DateTime dateTime1, DateTime dateTime2) {
  return dateTime1.day == dateTime2.day &&
      dateTime1.month == dateTime2.month &&
      dateTime1.year == dateTime2.year;
}
