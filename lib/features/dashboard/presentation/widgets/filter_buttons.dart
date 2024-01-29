import 'package:flutter/material.dart';
import 'package:point_of_sale/core/constants/strings.dart';
import 'package:point_of_sale/core/styles/placeholders.dart';
import 'package:point_of_sale/core/widgets/button.dart';


class FilterButtons extends StatelessWidget {
  const FilterButtons(
      {Key? key,
      required this.applyFiltersOnPressed,
      required this.resetFiltersOnPressed,
      this.isLoading = false})
      : super(key: key);
  final Future<void>? Function() resetFiltersOnPressed;
  final Future<void>? Function() applyFiltersOnPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final double buttonFontSize =
        Theme.of(context).textTheme.bodySmall!.fontSize!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ButtonWidget(
            text: "Reset Filters",
            textStyle: TextStyle(fontSize: buttonFontSize),
            onPressed: resetFiltersOnPressed,
            buttonType: ButtonType.transparent,
          ),
        ),
        sizeHorizontalFieldSmallPlaceHolder,
        Expanded(
            child: ButtonWidget(
          text: "Apply Filters",
          textStyle: TextStyle(fontSize: buttonFontSize),
          buttonType: ButtonType.fill,
          // isLoading: isLoading,
          onPressed: applyFiltersOnPressed,
        ))
      ],
    );
  }
}
