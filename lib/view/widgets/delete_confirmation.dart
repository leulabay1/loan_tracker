import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan_tracker_app/bloc/tebedari_bloc/tebedari_bloc.dart';
import 'package:loan_tracker_app/utils/validator.dart';
import 'package:loan_tracker_app/view/widgets/textfield.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class DeleteTebedariDialog extends StatefulWidget {
  final String id;
  DeleteTebedariDialog({required this.id});

  @override
  _DeleteTebedariDialogState createState() => _DeleteTebedariDialogState();
}

class _DeleteTebedariDialogState extends State<DeleteTebedariDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: const Key(
        "delete tebedari dialog",
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
                "Are you sure you want to delete this chigaram?",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 5.w),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  Theme.of(context).colorScheme.secondary),
                          minimumSize: MaterialStateProperty.resolveWith(
                              (states) => Size(25.w, 8.w))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: 4.w,
                                color:
                                    Theme.of(context).colorScheme.background),
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.resolveWith(
                              (states) => Size(25.w, 8.w))),
                      onPressed: () {
                        context
                            .read<TebedariBloc>()
                            .add(DeleteTebedari(id: widget.id));
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Yes',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 4.w),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
