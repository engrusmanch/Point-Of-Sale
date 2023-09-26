import 'package:flutter/material.dart';


/// Widget that renders a [Button] with transparent or fill background
/// Exposes [onPressed] function
class ButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final TextStyle? textStyle;
  final Color? borderColor;
  final EdgeInsetsGeometry margin;
  final bool isLoading;
  final ButtonType buttonType;
  final Icon? icon;
  final double height;
  final double? width;
  final double radius;
  final bool expand;

   ButtonWidget(
      {Key? key,
      this.onPressed,
      required this.text,
      this.textStyle,
      this.borderColor,
      this.margin = EdgeInsets.zero,
      required this.buttonType,
      this.isLoading = false,
      this.icon,
      this.width,
      this.expand = true,
      this.radius = 4.0,
      this.height = 45.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        backgroundColor: MaterialStateProperty.all(getBackgroundColor(context)),
        foregroundColor: MaterialStateProperty.all(getForegroundColor(context)),
        side: MaterialStateProperty.all(
          BorderSide(color: borderColor!),
        ),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          side:  BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(radius),
        )));

    return Container(
        height: height,
        margin: margin,
        width: width ?? (expand ? double.infinity : null),
        child: ElevatedButton.icon(
          icon: icon ?? const SizedBox(),
          style: buttonStyle,
          onPressed: isLoading ? null : onPressed,
          label: !isLoading
              ? Text(
                  text,
                  style: textStyle,
                  textAlign: TextAlign.center,
                )
              : SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(
                    color: getProgressIndicatorColor(context),
                  ),
                ),
        ));
  }

  getForegroundColor(BuildContext context) {
    return buttonType == ButtonType.fill
        ? Colors.white
        : Theme.of(context).colorScheme.primary;
  }

  getBackgroundColor(BuildContext context) {
    return buttonType == ButtonType.transparent
        ? Colors.transparent
        : buttonType == ButtonType.fill
            ? Theme.of(context).colorScheme.primary
            : Colors.white;
  }

  getProgressIndicatorColor(BuildContext context) {
    return buttonType == ButtonType.fill
        ? Colors.white
        : Theme.of(context).colorScheme.primary;
  }
}

class CardButton extends StatelessWidget {
  const CardButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onPressed})
      : super(key: key);

  final IconData icon;
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      expand: false,
      icon: Icon(icon),
      text: text,
      buttonType: ButtonType.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      radius: 10.0,
      height: 41.0,
      onPressed: onPressed,
    );
  }
}

enum ButtonType { transparent, fill, white }
