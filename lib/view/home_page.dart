import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_tracker_app/bloc/auth_cubit/auth_cubit.dart';
import 'package:loan_tracker_app/bloc/tebedari_bloc/tebedari_bloc.dart';
import 'package:loan_tracker_app/view/widgets/add_tebedari.dart';
import 'package:loan_tracker_app/view/widgets/change_password.dart';
import 'package:loan_tracker_app/view/widgets/custome_dialog.dart';
import 'package:loan_tracker_app/view/widgets/user_tile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  var currentTab = 1;

  @override
  void initState() {
    super.initState();
    _loadTebedaris(null);
  }

  void _loadTebedaris(bool? complete) {
    context.read<TebedariBloc>().add(LoadTebedaris(complete: complete));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(2.w)),
              child: IconButton(
                onPressed: () {
                  context.read<AuthCubit>().logout();
                },
                iconSize: 10.w,
                icon: const Icon(Icons.logout),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(2.w)),
              child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ChangePasswordDialog();
                      });
                },
                iconSize: 10.w,
                icon: const Icon(Icons.account_circle),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadTebedaris(currentTab == 1
              ? null
              : currentTab == 2
                  ? false
                  : true);
        },
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 20.w,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5.w),
                      bottomRight: Radius.circular(5.w))),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentTab = 1;
                        _loadTebedaris(null);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w, vertical: 1.5.w),
                      decoration: BoxDecoration(
                          color: currentTab != 1
                              ? Theme.of(context).colorScheme.background
                              : Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(2.w)),
                      child: Row(
                        children: [
                          Icon(
                            size: 8.w,
                            Icons.assignment_outlined,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            'All',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 5.w, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentTab = 2;
                      });
                      _loadTebedaris(false);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w, vertical: 1.5.w),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1.w,
                                blurRadius: 10.w,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5))
                          ],
                          color: currentTab != 2
                              ? Theme.of(context).colorScheme.background
                              : Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(2.w)),
                      child: Row(
                        children: [
                          Icon(
                            size: 8.w,
                            Icons.incomplete_circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            'Incomplete',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 5.w, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentTab = 3;
                      });
                      _loadTebedaris(true);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w, vertical: 1.5.w),
                      decoration: BoxDecoration(
                          color: currentTab != 3
                              ? Theme.of(context).colorScheme.background
                              : Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(2.w)),
                      child: Row(
                        children: [
                          Icon(
                            size: 8.w,
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            'Complete',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 5.w, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'List of all chigarams',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 6.w),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AddTebedariDialog();
                          });
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5.w,
            ),
            BlocBuilder<TebedariBloc, TebedariState>(
              builder: (context, state) {
                if (state is LoadingTebedaris) {
                  return const CircularProgressIndicator();
                }
                if (state is TebedarisLoaded) {
                  return Expanded(
                      child: ListView.separated(
                    itemBuilder: (context, index) {
                      return UserTile(tebedari: state.tebedaris[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 5.w,
                      );
                    },
                    itemCount: state.tebedaris.length,
                  ));
                }
                return const Center(
                  child: Text("Couldn't load data!"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
