import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileAvatar extends StatelessWidget {
  ProfileAvatar({required this.name, required this.size});
  final String name;
  final num size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: (1 / 4 * size).w),
      width: size.w,
      height: size.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular((size / 2).w),
          color: Theme.of(context).colorScheme.background),
      child: Text(name.substring(0, 1).toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: (2 / 3 * size).w,
              color: Theme.of(context).colorScheme.primary)),
    );
  }
}
