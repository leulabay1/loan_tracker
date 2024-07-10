import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan_tracker_app/bloc/tebedari_bloc/tebedari_bloc.dart';
import 'package:loan_tracker_app/utils/validator.dart';
import 'package:loan_tracker_app/view/widgets/textfield.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class AddTebedariDialog extends StatefulWidget {
  @override
  _AddTebedariDialogState createState() => _AddTebedariDialogState();
}

class _AddTebedariDialogState extends State<AddTebedariDialog> {
  late TextEditingController _nameController;
  late GlobalKey<FormState> _formkey;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _formkey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: const Key(
        "add tebedari dialog",
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5.w),
          height: 60.w,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Add Tebedari",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 6.w),
              ),
              Form(
                key: _formkey,
                child: CustomeTextField(
                  hintText: 'Name',
                  controller: _nameController,
                  validator: textValidator,
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.resolveWith(
                          (states) => Size(60.w, 13.w))),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      context
                          .read<TebedariBloc>()
                          .add(AddTebedari(name: _nameController.text));
                      _formkey.currentState!.reset();
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Add',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 5.w),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
