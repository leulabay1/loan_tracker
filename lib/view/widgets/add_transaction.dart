import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_tracker_app/bloc/tebedari_bloc/tebedari_bloc.dart';
import 'package:loan_tracker_app/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:loan_tracker_app/model/tebedari.dart';
import 'package:loan_tracker_app/utils/validator.dart';
import 'package:loan_tracker_app/view/widgets/amount_tile.dart';
import 'package:loan_tracker_app/view/widgets/profile_avatar.dart';
import 'package:loan_tracker_app/view/widgets/textfield.dart';
import 'package:loan_tracker_app/view/widgets/transaction_detail.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddTransactionDialog extends StatefulWidget {
  final String tebedariId;
  AddTransactionDialog({required this.tebedariId});

  @override
  _AddTransactionDialogState createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  late TextEditingController _amountController;
  late TextEditingController _reasonController;
  late GlobalKey<FormState> _formkey;
  bool _isCredit = false;

  @override
  void initState() {
    super.initState();
    _reasonController = TextEditingController();
    _amountController = TextEditingController();
    _formkey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: const Key(
        "add transaction dialog",
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5.w),
          height: 90.w,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Add Bidr",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 6.w),
                ),
                CustomeTextField(
                  hintText: 'Amount',
                  controller: _amountController,
                  inputType: TextInputType.number,
                  validator: amountValidator,
                ),
                CustomeTextField(
                  hintText: 'Reason',
                  controller: _reasonController,
                  inputType: TextInputType.text,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _isCredit,
                          onChanged: (val) {
                            setState(() {
                              _isCredit = !_isCredit;
                            });
                          },
                        ),
                        Text("Credit")
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: !_isCredit,
                          onChanged: (val) {
                            setState(() {
                              _isCredit = !_isCredit;
                            });
                          },
                        ),
                        Text("Debit")
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.resolveWith(
                            (states) => Size(60.w, 13.w))),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        context.read<TransactionBloc>().add(AddTransaction(
                            reason: _reasonController.text,
                            amount: _isCredit
                                ? num.parse(_amountController.text)
                                : -1 * num.parse(_amountController.text),
                            tebedariId: widget.tebedariId));
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
      ),
    );
  }
}
