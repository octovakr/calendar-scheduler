import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool expand;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;


  const CustomTextField({
    required this.label,
    this.expand = false,
    required this.onSaved,
    required this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (!expand) renderTextFormField(),
        if (expand) Expanded(child: renderTextFormField()),
      ]
    );
  }

  renderTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.grey[300],
        filled: true,
      ),
      cursorColor: Colors.grey,
      expands: expand,
      maxLines: expand ? null : 1,
      minLines: expand ? null : 1,

      // 저장했을 때
      onSaved: onSaved,
      // 검증할 때
      validator: validator,
    );
  }
}
