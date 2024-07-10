import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_tracker_app/bloc/tebedari_bloc/tebedari_bloc.dart';
import 'package:loan_tracker_app/model/tebedari.dart';
import 'package:loan_tracker_app/view/widgets/add_transaction.dart';
import 'package:loan_tracker_app/view/widgets/amount_tile.dart';
import 'package:loan_tracker_app/view/widgets/custome_dialog.dart';
import 'package:loan_tracker_app/view/widgets/delete_confirmation.dart';
import 'package:loan_tracker_app/view/widgets/profile_avatar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserTile extends StatelessWidget {
  final Tebedari tebedari;

  UserTile({required this.tebedari});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return CustomeDialog(
                tebedari: tebedari,
              );
            });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.w),
            color: Theme.of(context).colorScheme.tertiary),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileAvatar(name: tebedari.name, size: 15),
            SizedBox(
              width: 3.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 34.w,
                        child: Text(tebedari.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displayLarge),
                      ),
                      AmountTile(
                          amount: tebedari.credit - tebedari.debit,
                          isCredit: tebedari.credit - tebedari.debit > 0),
                      PopupMenuButton(
                        padding: EdgeInsets.zero,
                        constraints:
                            BoxConstraints(maxHeight: 40.w, maxWidth: 35.w),
                        iconColor: Theme.of(context).colorScheme.primary,
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomeDialog(
                                          tebedari: tebedari,
                                        );
                                      });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.list,
                                      size: 8.w,
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Text("Detail"),
                                  ],
                                )),
                            PopupMenuItem(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AddTransactionDialog(
                                          tebedariId: tebedari.id,
                                        );
                                      });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.plus_one,
                                      size: 8.w,
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Text("Add debit"),
                                  ],
                                )),
                            PopupMenuItem(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DeleteTebedariDialog(
                                          id: tebedari.id,
                                        );
                                      });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      size: 8.w,
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Text("Delete user"),
                                  ],
                                )),
                          ];
                        },
                      )
                    ],
                  ),
                  Text(
                    tebedari.lastReason,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5)),
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.output_outlined,
                                size: 9.w,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              SizedBox(
                                width: 36.w,
                                child: Text(
                                  "${tebedari.debit} Birr taken",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2.w,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.input_outlined,
                                size: 9.w,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              SizedBox(
                                width: 36.w,
                                child: Text(
                                  "${tebedari.credit} Birr Paid",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 3.w),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 17.w,
                              height: 17.w,
                              child: CircularProgressIndicator(
                                value: tebedari.debit != 0
                                    ? (tebedari.credit / tebedari.debit)
                                    : 1,
                                strokeWidth: 1.6.w,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Text(
                              tebedari.credit < tebedari.debit
                                  ? "${((tebedari.credit / tebedari.debit) * 100).toInt()}%"
                                  : '100%',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 5.w),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
