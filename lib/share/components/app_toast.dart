import 'package:flutter/material.dart';

import 'package:toastification/toastification.dart';

import '../themes/text_style.dart';
import '../utils/colors/colors.dart';

class AppToast {
  static void showInfo(BuildContext context, String title, String description) {
    var notify = toastification.show(
      context: context,
      title: Text(title, style: AppTextStyle().titleTextStyle.bold),
      description: Text(description, style: AppTextStyle().caption02.regular),
      alignment: Alignment.bottomCenter,
    );
    Future.delayed(
      const Duration(seconds: 3),
      () {
        toastification.dismiss(notify);
      },
    );
  }

  static void showError(BuildContext context, String title, String description) {
    var notify = toastification.show(
      context: context,
      title: Text(title, style: AppTextStyle().titleTextStyle.bold),
      description: Text(description, style: AppTextStyle().caption02.regular),
      alignment: Alignment.bottomCenter,
      icon: const Icon(
        Icons.error_outline,
        color: Colors.red,
      ),
      borderSide: const BorderSide(color: Colors.red),
    );
    Future.delayed(
      const Duration(seconds: 3),
      () {
        toastification.dismiss(notify);
      },
    );
  }

  static void showCustomInfo(BuildContext context, String title,{Alignment alignment = Alignment.bottomCenter}) {
    var notify = toastification.showCustom(
      context: context,
      alignment:alignment,
      builder: (BuildContext context, ToastificationItem holder) {
        return Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(title, style: AppTextStyle().caption02.regular),
                ],
              ),
            ));
      },
    );
    Future.delayed(
      const Duration(seconds: 3),
      () {
        toastification.dismiss(notify);
      },
    );
  }

  static void showDeleteInfo(
    BuildContext context,
    String messages,
    String name,
  ) {
    List<String> split = splitByName(context, messages, name);
    var notify = toastification.showCustom(
      context: context,
      alignment: Alignment.bottomCenter,
      builder: (BuildContext context, ToastificationItem holder) {
        return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: RichText(
                        text: TextSpan(
                      children: split.map((e) {
                        return TextSpan(
                          text: '$e ',
                          style: AppTextStyle()
                              .caption02
                              .regular
                              .copyWith(color: e.trim() == name.trim() ? Colors.blue : Colors.white),
                        );
                      }).toList(),
                    )),
                  )
                ],
              ),
            ));
      },
    );
    Future.delayed(
      const Duration(seconds: 3),
      () {
        toastification.dismiss(notify);
      },
    );
  }

  static List<String> splitByName(BuildContext context, String message, String name) {
    List<String> result = [];

    message.splitMapJoin(name, onMatch: (match) {
      result.add(match.group(0)!);
      return match.group(0)!;
    }, onNonMatch: (nonMatch) {
      result.add(nonMatch);
      return nonMatch;
    });
    return result;
  }
}
