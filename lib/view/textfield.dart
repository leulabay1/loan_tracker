import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomeTextField extends StatefulWidget {

  const CustomeTextField({
    required this.hintText,
    required this.controller,
    this.value = '',
    this.lines = 1,
    this.labelText = '',
    this.inputType = TextInputType.text
  });

  final String hintText;
  final TextEditingController controller;
  final String value;
  final int lines;
  final String labelText;
  final TextInputType inputType;

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

    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      maxLines: null,
      minLines: widget.lines,
      keyboardType: widget.inputType,
      controller: widget.controller,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        constraints: BoxConstraints(
          maxWidth: 90.w
        ),
        label: Text(widget.hintText),
        hintText: widget.labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.w)
        ),
        alignLabelWithHint: true
      ),
    );
  }
}