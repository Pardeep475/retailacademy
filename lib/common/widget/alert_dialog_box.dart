import 'package:flutter/material.dart';

class AlertDialogBox extends StatelessWidget {
  // This is generic AlertBox class for using anywhere
  // few parms is a required, passing a color and text
  // here creating a AlertBox

  final BuildContext context;
  final bool barrierDismissible;
  final Widget child;
  final bool? showCrossIcon;
  final EdgeInsetsGeometry? padding;

  const AlertDialogBox(
      {Key? key,
      required this.context,
      required this.barrierDismissible,
      required this.child,
      this.padding,
      this.showCrossIcon})
      : super(key: key);

  show() async {
    await showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () {
            if (barrierDismissible == true) {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            }
            return Future.value(barrierDismissible);
          },
          child: AlertDialog(
            elevation: 6.0,
            backgroundColor: Colors.white,
            // insetPadding: const EdgeInsets.all(13),
            contentPadding: const EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.antiAlias,
            content: Container(
              padding: padding ?? const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
