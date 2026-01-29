import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
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
                _SaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onStartTimeSaved(String? val) {

  }

  String? onStartTimeValidate(String? val) {

  }

  void onEndTimeSaved(String? val) {

  }

  String? onEndTimeValidate(String? val) {

  }

  void onContentSaved(String? val) {

  }

  String? onContentValidate(String? val) {

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
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: (){

            },
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
