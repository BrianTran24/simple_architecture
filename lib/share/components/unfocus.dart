import 'package:flutter/material.dart';

class UnFocus extends StatelessWidget {
  const UnFocus({Key? key, required this.child, this.additionUnFocusAction}) : super(key: key);

  final Widget child;

  final VoidCallback? additionUnFocusAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (primaryFocus != null){
          additionUnFocusAction?.call();
          primaryFocus!.unfocus();
        }
      },
      child: child,
    );
  }
}

class DisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
