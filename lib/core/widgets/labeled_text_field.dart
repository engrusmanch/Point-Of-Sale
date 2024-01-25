import 'package:flutter/material.dart';
import 'package:point_of_sale/core/styles/placeholders.dart';
import 'package:point_of_sale/core/styles/styles.dart';



class LabeledTextField<T> extends StatelessWidget {
  const LabeledTextField(
      {Key? key,
      required this.label,
      required this.fontSize,
      this.fontWeight = FontWeight.bold,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      required this.textField})
      : super(key: key);
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget textField;
  final CrossAxisAlignment crossAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.0,
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              width: AppStyles.widthLabel,
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleSmall,
              )),
          sizeHorizontalFieldMinPlaceHolder,
          Flexible(child: textField),
        ],
      ),
    );
  }
}
