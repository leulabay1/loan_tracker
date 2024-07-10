import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_tracker_app/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:loan_tracker_app/model/tebedari.dart';
import 'package:loan_tracker_app/view/widgets/amount_tile.dart';
import 'package:loan_tracker_app/view/widgets/profile_avatar.dart';
import 'package:loan_tracker_app/view/widgets/transaction_detail.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomeDialog extends StatefulWidget {
  final Tebedari tebedari;

  CustomeDialog({required this.tebedari});

  @override
  _CustomeDialogState createState() => _CustomeDialogState();
}

class _CustomeDialogState extends State<CustomeDialog> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    context
        .read<TransactionBloc>()
        .add(LoadTransactions(tebedariId: widget.tebedari.id));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: const Key("dialog box"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
                top: -23.w,
                child: ProfileAvatar(name: widget.tebedari.name, size: 30)),
            Container(
              height: 80.w,
              padding: EdgeInsets.only(
                  right: 5.w, left: 5.w, bottom: 2.w, top: 10.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Credit",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          AmountTile(
                              amount: widget.tebedari.credit, isCredit: true)
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Debit",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          AmountTile(
                              amount: widget.tebedari.debit, isCredit: false)
                        ],
                      )
                    ],
                  ),
                  BlocBuilder<TransactionBloc, TransactionState>(
                    builder: (context, state) {
                      if (state is TransactionLoading) {
                        return CircularProgressIndicator();
                      }

                      if (state is TransactionLoaded) {
                        return Expanded(
                          child: Scrollbar(
                            controller: _scrollController,
                            child: ListView.separated(
                                controller: _scrollController,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return SizedBox(
                                      height: 3.w,
                                    );
                                  }
                                  return TransactionDetailTile(
                                    tebedariId: widget.tebedari.id,
                                    transaction: state.transaction[index - 1],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 3.w,
                                  );
                                },
                                itemCount: state.transaction.length + 1),
                          ),
                        );
                      }

                      return const Center(child: Text("Couldnt load data!"));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
