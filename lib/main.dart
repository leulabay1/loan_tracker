import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loan_tracker_app/bloc/auth_cubit/auth_cubit.dart';
import 'package:loan_tracker_app/bloc/tebedari_bloc/tebedari_bloc.dart';
import 'package:loan_tracker_app/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:loan_tracker_app/model/tebedari.dart';
import 'package:loan_tracker_app/model/transaction.dart';
import 'package:loan_tracker_app/respository/app_repository.dart';
import 'package:loan_tracker_app/view/home_page.dart';
import 'package:loan_tracker_app/view/login_page.dart';
import 'package:loan_tracker_app/view/theme/theme.dart';
import "package:responsive_sizer/responsive_sizer.dart";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TebedariAdapter());
  await Hive.openBox<Transaction>('transaction');
  await Hive.openBox<Tebedari>('tebedari');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AppRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: ((context) =>
                  AuthCubit(appRepository: context.read<AppRepository>())
                    ..check())),
          BlocProvider(
              create: ((context) =>
                  TebedariBloc(appRepository: context.read<AppRepository>()))),
          BlocProvider(
              create: ((context) => TransactionBloc(
                  appRepository: context.read<AppRepository>(),
                  tebedariBloc: context.read<TebedariBloc>())))
        ],
        child: ResponsiveSizer(builder: (context, Orientation, ScreenType) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeClass.darkTheme,
            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) return HomePage();
                return LoginPage();
              },
            ),
          );
        }),
      ),
    );
  }
}
