class Schedule {
  // id
  final int id;
  // start time
  final int startTime;
  // end time
  final int endTime;
  // content
  final String content;
  // date
  final DateTime date;
  // category
  final String color;
  // data generated datetime
  final DateTime createdAt;

  Schedule({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.date,
    required this.color,
    required this.createdAt,
  });

}