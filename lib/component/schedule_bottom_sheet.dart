import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDay;

  const ScheduleBottomSheet({
    required this.selectedDay,
    super.key,
  });

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  int? startTime;
  int? endTime;
  String? content;
  String selectedColor = categoryColors.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 600,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(8, 16, 8, 0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _Time(
                  onStartSaved: onStartTimeSaved,
                  onStartValidate: onStartTimeValidate,
                  onEndSaved: onEndTimeSaved,
                  onEndValidate: onEndTimeValidate,
                ),
                SizedBox(height: 8),
                _Content(
                  onSaved: onContentSaved,
                  validator: onContentValidate,
                ),
                SizedBox(height: 8),
                _Categories(
                  selectedColor: selectedColor,
                  onTap: (String color){
                    setState(() {
                      selectedColor = color;
                    });
                  },
                ),
                SizedBox(height: 8),
                _SaveButton(
                  onPressed: onSaveButtonPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSaveButtonPressed() {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      formKey.currentState!.save();

      // final schedule = ScheduleTable(
      //   id: 999,
      //   startTime: startTime!,
      //   endTime: endTime!,
      //   content: content!,
      //   color: selectedColor,
      //   date: widget.selectedDay,
      //   createdAt: DateTime.now().toUtc(),
      // );

      // Navigator.of(context).pop(schedule);
    }
  }

  void onStartTimeSaved(String? val) {
    if (val == null) return;
    startTime = int.parse(val);
  }

  String? onStartTimeValidate(String? val) {
    if (val == null) {
      return '시작 시간을 입력해주세요.';
    }
    if (int.tryParse(val) == null) {
      return '숫자만 입력해주세요.';
    }
    final time = int.parse(val);
    if (time > 24 || time < 0) {
      return '0 ~ 24시 사이로 입력해주세요.';
    }
    return null;
  }

  void onEndTimeSaved(String? val) {
    if (val == null) return;
    endTime = int.parse(val);
  }

  String? onEndTimeValidate(String? val) {
    if (val == null) {
      return '시작 시간을 입력해주세요.';
    }
    if (int.tryParse(val) == null) {
      return '숫자만 입력해주세요.';
    }
    final time = int.parse(val);
    if (time > 24 || time < 0) {
      return '0 ~ 24시 사이로 입력해주세요.';
    }
    return null;
  }

  void onContentSaved(String? val) {
    if (val == null) return;
    content = val;
  }

  String? onContentValidate(String? val) {
    if (val == null) {
      return '내용을 입력해주세요.';
    }
    if (val.length < 5) {
      return '5자 이상 입력해주세요.';
    }
    return null;
  }
}

class _Time extends StatelessWidget {
  // 이 프로젝트 전체에 global하게 단 하나만 존재하는 key 값을 만들어서 그 안에 form의 상태를 저장.
  // final GlobalKey<FormState> formKey = GlobalKey(); // 공식처럼 알아두기.
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final FormFieldValidator<String> onStartValidate;
  final FormFieldValidator<String> onEndValidate;

  _Time({
    required this.onStartSaved,
    required this.onEndSaved,
    required this.onStartValidate,
    required this.onEndValidate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: CustomTextField(
                  label: '시작 시간',
                  onSaved: onStartSaved,
                  validator: onStartValidate,
                ),
            ),
            SizedBox(width: 16.0),
            Expanded(
                child: CustomTextField(
                  label: '마감 시간',
                  onSaved: onEndSaved,
                  validator: onEndValidate,
                ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const _Content({
    required this.onSaved,
    required this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }
}

typedef onColorSelected = void Function(String color);

class _Categories extends StatelessWidget {
  final String selectedColor;
  final onColorSelected onTap;

  const _Categories({
    required this.selectedColor,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categoryColors
          .map(
            (e) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: (){
              onTap(e);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(
                  int.parse('ff$e', radix: 16),
                ),
                border: e == selectedColor ? Border.all(
                  color: Colors.black,
                  width: 3.0,
                ) : null,
              ),
              width: 32,
              height: 32,
            ),
          ),
        ),
      )
          .toList(),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}
