import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_tracker_app/bloc/auth_cubit/auth_cubit.dart';
import 'package:loan_tracker_app/utils/validator.dart';
import 'package:loan_tracker_app/view/widgets/textfield.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formkey;

  @override
  void initState() {
    super.initState();
    _formkey = GlobalKey<FormState>();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: 35.h,
                  maxWidth: 35.h,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/load-vector.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10.w,
              ),
              CustomeTextField(
                controller: _passwordController,
                hintText: 'Password',
                password: true,
                validator: passwordValidator,
              ),
              SizedBox(
                height: 10.w,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.resolveWith(
                          (states) => Size(60.w, 13.w))),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      context.read<AuthCubit>().login(_passwordController.text);
                      _formkey.currentState!.reset();
                    }
                  },
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticating) {
                        return CircularProgressIndicator();
                      }
                      if (state is Unauthenticated) {
                        return Text(
                          'Wrong Password',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 5.w),
                        );
                      }
                      return Text(
                        'Login',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 5.w),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
