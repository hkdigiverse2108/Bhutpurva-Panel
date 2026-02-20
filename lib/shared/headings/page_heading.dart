import 'package:flutter/material.dart';

class PageHeadings extends StatelessWidget {
  const PageHeadings({super.key, required this.heading, this.rightSideWidget});

  final String heading;
  final Widget? rightSideWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(heading, style: Theme.of(context).textTheme.titleLarge),
        rightSideWidget ?? const SizedBox(),
      ],
    );
  }
}
