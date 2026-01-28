import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime
        .now()
        .year,
    DateTime
        .now()
        .month,
    DateTime
        .now()
        .day,
  );

  /// {
  ///   2026-01-28: [Schedule, Schedule],
  ///   2026-01-29: [Schedule, Schedule],
  /// }
  Map<DateTime, List<Schedule>> schedules = {
    DateTime.utc(2026, 1, 10): [
      Schedule(
        id: 1,
        startTime: 11,
        endTime: 12,
        content: '플러터 공부하기',
        date: DateTime.utc(2026, 1, 10),
        color: categoryColors[0],
        createdAt: DateTime.now().toUtc(),
      ),
      Schedule(
        id: 2,
        startTime: 14,
        endTime: 16,
        content: '회의',
        date: DateTime.utc(2026, 1, 10),
        color: categoryColors[1],
        createdAt: DateTime.now().toUtc(),
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return ScheduleBottomSheet();
            },
          );
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              focusedDay: DateTime(2026, 1, 1),
              onDaySelected: onDaySelected,
              selectedDayPredicate: selectedDayPredicate,
            ),
            TodayBanner(selectedDay: selectedDay, taskCount: 0),
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.fromLTRB(16, 16, 16, 0),

                /// ListView는 children 안에 입력된 모든 위젯을 한번에 그리며,
                /// 모든 것을 메모리에 들고 있으므로, 데이터가 많아지면 퍼포먼스가 느려짐.
                /// 하드웨어를 적게 사용하려면 lazy loading을 해야 함.
                // child: ListView(
                // children: schedules.containsKey(selectedDay)
                //     ? schedules[selectedDay]!
                //           .map(
                //             (e) => ScheduleCard(
                //               startTime: e.startTime,
                //               endTime: e.endTime,
                //               content: e.content,
                //               color: Color(
                //                 int.parse('ff${e.color}', radix: 16),
                //               ),
                //             ),
                //           )
                //           .toList()
                //     : [],
                // ),
                /// 많은 데이터를 화면에 보여주기 위해 lazy loading을 해야 할 때,
                /// ListView.builder 또는 ListView.separated를 적극 활용 가능함.
                /// ListView.separated에서는 separatorBuilder를 통해서,
                /// 각 위젯 사이사이에 무언가를 렌더링해줄 수 있다.
                child: ListView.separated(
                  itemCount: schedules.containsKey(selectedDay)
                      ? schedules[selectedDay]!.length
                      : 0,
                  itemBuilder: (BuildContext context, int index) {
                    final selectedSchedules = schedules[selectedDay]!;
                    final scheduleModel = selectedSchedules[index];

                    return ScheduleCard(
                        startTime: scheduleModel.startTime,
                        endTime: scheduleModel.endTime,
                        content: scheduleModel.content,
                        color: Color(
                          int.parse('ff${scheduleModel.color}', radix: 16),
                        ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(DateTime date) {
    // 현재 화면상 모든 날짜를 date로 받음
    if (selectedDay == null) return false;
    return date.isAtSameMomentAs(selectedDay!);
  }
}
