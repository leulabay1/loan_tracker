import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loan_tracker_app/model/transaction.dart';
import 'package:loan_tracker_app/view/textfield.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late Box<Transaction> transactionBox;
  late List<Transaction> transactions;
  TextEditingController amountController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  var uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    transactionBox = Hive.box<Transaction>('transaction');
    transactions = transactionBox.values.toList();
    var value = transactionBox.get('');
    transactions.sort((a, b) => -1 * a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Tracker'),
        actions: [
          IconButton(
            onPressed: () {
              viewDialog(context, true);
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              viewDialog(context, false);
            },
            icon: Icon(Icons.minimize),
          )
        ],
      ),
      body: Container(
          child: ListView.separated(
              itemCount: transactions.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    color: Colors.grey,
                    child: Text(
                        'Total: ${transactions.fold(0, (previousValue, element) => previousValue.toInt() + element.amount.toInt())}'),
                  );
                }
                return Dismissible(
                  key: Key(transactions[index - 1].id),
                  onDismissed: (direction) {
                    transactionBox.delete(transactions[index - 1].id);
                    setState(() {
                      transactions = transactionBox.values.toList();
                      transactions
                          .sort((a, b) => -1 * a.date.compareTo(b.date));
                    });
                  },
                  child: ListTile(
                    leading: Text(transactions[index - 1].amount.toString()),
                    title: Text(transactions[index - 1].title),
                    subtitle: Text(formatDate(transactions[index - 1].date,
                        [dd, ' ', M, ' ', yyyy, ' '])),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider())),
    );
  }

  viewDialog(BuildContext context, bool add) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              key: const Key("profile dialog"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.w),
              ),
              child: SingleChildScrollView(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 15.w),
                          CustomeTextField(
                            hintText: 'Amount',
                            controller: amountController,
                            inputType: TextInputType.number,
                          ),
                          SizedBox(height: 5.w),
                          CustomeTextField(
                            hintText: 'Reason',
                            controller: reasonController,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (amountController.text.isEmpty ||
                                  reasonController.text.isEmpty) return;

                              final id = uuid.v4();
                              transactionBox.put(
                                  id,
                                  Transaction(
                                      id: id,
                                      amount: add
                                          ? double.parse(amountController.text)
                                          : -1 *
                                              double.parse(
                                                  amountController.text),
                                      title: reasonController.text,
                                      date: DateTime.now()));
                              setState(() {
                                transactions = transactionBox.values.toList();
                                transactions.sort(
                                    (a, b) => -1 * a.date.compareTo(b.date));
                              });
                              Navigator.pop(context);
                            },
                            child: Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
