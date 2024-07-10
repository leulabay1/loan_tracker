import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomeTextField extends StatefulWidget {
  CustomeTextField(
      {required this.hintText,
      required this.controller,
      this.validator,
      this.value = '',
      this.lines = 1,
      this.labelText = '',
      this.inputType = TextInputType.text,
      this.password = false});

  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String value;
  final int lines;
  final String labelText;
  final TextInputType inputType;
  final bool password;
  bool isObscure = true;

  @override
  State<StatefulWidget> createState() => _CustomeTextFieldState();
}

class _CustomeTextFieldState extends State<CustomeTextField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          maxLines: 1,
          minLines: widget.lines,
          keyboardType: widget.inputType,
          controller: widget.controller,
          obscureText: widget.password ? widget.isObscure : false,
          obscuringCharacter: '*',
          style:
              Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 4.2.w),
          validator: widget.validator,
          decoration: InputDecoration(
              constraints: BoxConstraints(maxWidth: 90.w),
              label: Text(widget.hintText),
              hintText: widget.labelText,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(3.w)),
              alignLabelWithHint: true),
        ),
        widget.password
            ? IconButton(
                iconSize: 8.w,
                onPressed: () {
                  setState(() {
                    widget.isObscure = !widget.isObscure;
                  });
                },
                icon: Icon(Icons.remove_red_eye_outlined),
              )
            : SizedBox()
      ],
    );
  }
}
