import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan_tracker_app/bloc/auth_cubit/auth_cubit.dart';
import 'package:loan_tracker_app/bloc/tebedari_bloc/tebedari_bloc.dart';
import 'package:loan_tracker_app/utils/validator.dart';
import 'package:loan_tracker_app/view/widgets/textfield.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class ChangePasswordDialog extends StatefulWidget {
  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formkey;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _formkey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: const Key(
        "change password dialog",
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
                "Change password",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 6.w),
              ),
              SizedBox(
                height: 5.w,
              ),
              Form(
                key: _formkey,
                child: CustomeTextField(
                  hintText: 'Password',
                  controller: _passwordController,
                  password: true,
                  validator: passwordValidator,
                ),
              ),
              SizedBox(
                height: 5.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).colorScheme.error),
                        minimumSize: MaterialStateProperty.resolveWith(
                            (states) => Size(25.w, 8.w))),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        context.read<AuthCubit>().deletePassword();
                        _formkey.currentState!.reset();
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Erase',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 5.w,
                          ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).colorScheme.primary),
                        minimumSize: MaterialStateProperty.resolveWith(
                            (states) => Size(25.w, 8.w))),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        context
                            .read<AuthCubit>()
                            .changePassword(_passwordController.text);
                        _formkey.currentState!.reset();
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Change',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 5.w),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
