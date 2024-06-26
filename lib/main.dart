import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loan_tracker_app/model/transaction.dart';
import 'package:loan_tracker_app/view/home_page.dart';
import "package:responsive_sizer/responsive_sizer.dart";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transaction');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, Orientation, ScreenType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(),
      );
    });
  }
}
