import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_tracker_app/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:loan_tracker_app/model/transaction.dart';
import 'package:loan_tracker_app/view/widgets/amount_tile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TransactionDetailTile extends StatelessWidget {
  final Transaction transaction;
  final String tebedariId;
  TransactionDetailTile({required this.transaction, required this.tebedariId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Theme.of(context).colorScheme.error.withOpacity(0.5),
      ),
      key: Key(transaction.id),
      onDismissed: (direction) {
        context
            .read<TransactionBloc>()
            .add(DeleteTransaction(id: transaction.id, tebedariId: tebedariId));
      },
      confirmDismiss: (DismissDirection dismissDirection) async {
        switch (dismissDirection) {
          case DismissDirection.endToStart:
            return await _showConfirmationDialog(context) == true;
          case DismissDirection.startToEnd:
            return await _showConfirmationDialog(context) == true;
          case DismissDirection.horizontal:
          case DismissDirection.vertical:
          case DismissDirection.up:
          case DismissDirection.down:
          case DismissDirection.none:
            assert(false);
        }
        return false;
      },
      child: Container(
        width: 75.w,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.w),
            color: Theme.of(context).colorScheme.tertiary),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 39.w,
                  child: Text(
                    transaction.reason,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 4.w),
                    softWrap: true,
                  ),
                ),
                AmountTile(
                    amount: transaction.amount,
                    isCredit: transaction.amount > 0)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                        size: 7.w,
                        Icons.access_time,
                        color: Theme.of(context).colorScheme.primary),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(formatDate(transaction.date, [HH, ':', nn, ' ', am]))
                  ],
                ),
                Row(
                  children: [
                    Icon(
                        size: 7.w,
                        Icons.calendar_today,
                        color: Theme.of(context).colorScheme.primary),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(formatDate(transaction.date,
                        [DD.substring(0, 1), ', ', mm, ' ', yyyy]))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do you want to delete this transaction?'),
          actions: <Widget>[
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
                      Navigator.pop(context, false);
                    },
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 4.w,
                          color: Theme.of(context).colorScheme.background),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.resolveWith(
                            (states) => Size(25.w, 8.w))),
                    onPressed: () {
                      Navigator.pop(context, true);
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
        );
      },
    );
  }
}
