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
  const _Time({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CustomTextField(label: '시작 시간')),
        SizedBox(width: 16.0),
        Expanded(child: CustomTextField(label: '마감 시간')),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(label: '내용', expand: true),
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
