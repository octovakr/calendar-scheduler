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
          child: Column(
            children: [
              _Time(),
              SizedBox(height: 8),
              _Content(),
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
    );
  }
}

class _Time extends StatelessWidget {
  // 이 프로젝트 전체에 global하게 단 하나만 존재하는 key 값을 만들어서 그 안에 form의 상태를 저장.
  final GlobalKey<FormState> formKey = GlobalKey(); // 공식처럼 알아두기.

  _Time({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                    label: '시작 시간',
                    onSaved: (String? val){

                    },
                    validator: (String? val){
                      print('start time validate');
                      return 'start time error!!!!!';
                    },
                  ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                  child: CustomTextField(
                    label: '마감 시간',
                    onSaved: (String? val){

                    },
                    validator: (String? val){
                      print('end time validate');
                      return 'end time error!!!!!';
                    },
                  ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: (){
                final validated = formKey.currentState!.validate();
                // formKey를 넣어준 form 내부의 텍스트필드 위젯에서
                // validator 파라미터에 들어간 함수가 String을 반환하는 경우가 하나라도 있으면
                // formKey.currentState.validate()는 false를 반환함. (검증 안됨)
                print('-----validated-----');
                print(validated);
              },
              child: Text('save'),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
        onSaved: (String? val){

        },
        validator: (String? val){

        },
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
