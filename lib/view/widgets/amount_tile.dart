import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AmountTile extends StatelessWidget {
  AmountTile({required this.amount, required this.isCredit});

  final num amount;
  final bool isCredit;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 21.w),
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.5.w),
        color: isCredit
            ? Theme.of(context).colorScheme.scrim.withOpacity(0.36)
            : Theme.of(context).colorScheme.error.withOpacity(0.2),
      ),
      child: Text(isCredit ? "+${amount} Br" : "${amount} Br",
          overflow: TextOverflow.ellipsis,
          style: isCredit
              ? Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.scrim)
              : Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.error)),
    );
  }
}
