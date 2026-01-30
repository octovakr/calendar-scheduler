import 'package:drift/drift.dart';

// model을 drift table로 변환

class Schedule extends Table {
  // id
  IntColumn get id => integer().autoIncrement()();

  // start time
  IntColumn get startTime => integer()();

  // end time
  IntColumn get endTime => integer()();

  // content
  TextColumn get content => text()();

  // date
  DateTimeColumn get date => dateTime()();

  // category
  TextColumn get color => text()();

  // data generated datetime
  DateTimeColumn get createdAt => dateTime().clientDefault(
          () => DateTime.now().toUtc(),
  )();

}