import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:point_of_sale/core/enums.dart';
import 'package:point_of_sale/core/styles/placeholders.dart';
import 'package:point_of_sale/core/utils/validators.dart';

import '../styles/styles.dart';


class DropDownWidget<T> extends StatefulWidget {
  const DropDownWidget({
    Key? key,
    this.items,
    this.asyncItems,
    this.hint,
    required this.onChanged,
    this.value,
    this.label,
    this.labelFontSize,
    this.margin,
    this.validate = false,
    this.popupType = PopupType.dialog,
    this.showSearchField = true,
    this.smallDropdown = false,
    this.isFilterOnline = true,
    this.enabled = true,
  }) : super(key: key);
  final List<T>? items;
  final String? hint;
  final void Function(T?) onChanged;
  final T? value;
  final String? label;
  final double? labelFontSize;
  final bool validate;
  final EdgeInsets? margin;
  final Future<List<T>> Function(String)? asyncItems;
  final PopupType popupType;
  final bool showSearchField;
  final bool isFilterOnline;
  final bool? smallDropdown;
  final bool enabled;
  @override
  State<DropDownWidget<T>> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T> extends State<DropDownWidget<T>> {
  T? value;

  @override
  initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    // double smallFontSize = textTheme.bodySmall!.fontSize!;
    double mediumFontSize = textTheme.bodyMedium!.fontSize!;

    return SizedBox(
      width: 350.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.label != null) ...[
            SizedBox(
                width: widget.smallDropdown! ? null : AppStyles.widthLabel,
                child: Text(
                  widget.label!,
                  style: TextStyle(
                      fontSize: widget.labelFontSize,
                      fontWeight: FontWeight.bold),
                )),
            sizeHorizontalFieldMinPlaceHolder
          ],
          Flexible(
            child: Container(
              // height: AppDimensions.sizeTextField,
              width: widget.smallDropdown! ? 150.0 : null,
              margin: widget.margin,
              child: Theme(
                data: Theme.of(context).copyWith(
                    textTheme: Theme.of(context).textTheme.copyWith(
                          titleMedium: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: widget.enabled ? null : Colors.grey,
                                  fontSize: mediumFontSize,
                                  overflow: TextOverflow.ellipsis),
                        )),
                child: DropdownSearch<T>(
                  enabled: widget.enabled,
                  clearButtonProps: const ClearButtonProps(
                    isVisible: true
                  ),
                  popupProps: getPopupProps(),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      baseStyle:
                          const TextStyle(overflow: TextOverflow.ellipsis),
                      dropdownSearchDecoration: InputDecoration(
                        hintText: widget.hint,
                      )),
                  validator:
                      widget.validate ? EmptyFieldValidator.validator : null,
                  selectedItem: value,
                  items: widget.items ?? [],
                  asyncItems: widget.asyncItems,
                  onChanged: (newValue) {
                    setState(() {
                      value = newValue;
                    });
                    widget.onChanged(newValue);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getPopupProps() {
    return widget.popupType == PopupType.dialog
        ? PopupProps<T>.dialog(
            showSearchBox: widget.showSearchField,
            isFilterOnline: widget.isFilterOnline)
        : PopupProps<T>.modalBottomSheet(
            showSearchBox: widget.showSearchField,
            isFilterOnline: widget.isFilterOnline);
  }
}
