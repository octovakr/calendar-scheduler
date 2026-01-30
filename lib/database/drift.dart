import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
// path.dart 안의 모든 기능을 p라는 변수에 넣어서 사용하겠다.
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

part 'drift.g.dart'; // 여기 적은 파일이 현재 파일과 함께 있는 것처럼 인식해라.
// g : generated (생성된) 파일
// '생성'하려면, 일단 다른 모든 파일에서 에러를 없애고 와야 한다.
// 없애고 와서 터미널에 dart run build_runner build 실행하면 database/drift.g.dart가 생성됨
// 그 안에 _$AppDatabase 클래스가 생겼음.

@DriftDatabase(
  tables: [ScheduleTable]
) // annotation(@~) 바로 밑 코드에는 기능이 추가된다. (AppDatabase 기반 코드 생성을 도와줌.)
class AppDatabase extends _$AppDatabase {
  // code generation은 우리 코드를 보고 이름을 짓는다. 꼭 _$(클래스이름)을 extend 해줘야 한다.
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
  /// 우리가 만드는 테이블 상태는 버전으로 관리된다.
  /// ex. 만약 배포 후 스키마 필드에 author라는 필드가 추가된다면
  /// 버전 정보가 최신화되어 '어떤 칼럼이 생성되어야 한다'라는 정보를 알려줄 수 있다.
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory(); // From path_provider
    // 폰에 앱을 설치하면 앱별로 생성되는 ApplicationDocuments 파일이 있다.
    // 그 폴더를 가져오는 코드가 위 코드이다.

    final file = File(p.join(dbFolder.path, 'db.sqlite')); // dart:io에서 불러와야 한다.
    // p.join는 현재 운영체제에 맞게 알아서 여러 개의 경로를 합쳐 준다.
    // ex) Users/taixii//calendar_scheduler_mobileApp/db.sqlite

    // if(Platform.isAndroid) {
    //   await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    // }
    // 옛날 안드로이드 버전의 문제를 해결하기 위한 코드인데 지금은 deprecated 된듯함

    final cachebase = await getTemporaryDirectory();
    sqlite3.tempDirectory = cachebase.path;
    // 혹시 sqlite가 '임시 파일 위치'가 어딘지 모를까봐 직접 지정해준 거임. 중요도 낮음.

    return NativeDatabase.createInBackground(file);
    // file 위치에다가 database를 생성한다.
  });
}