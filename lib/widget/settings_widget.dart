import 'package:flutter/material.dart';

import '../shared/theme.dart';

// ignore: must_be_immutable
class Settings extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Icon? icons;
  void Function()? onTap;
  Settings({this.title, this.subtitle, this.icons, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icons!.icon,
            size: 24,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: regularTextStyle.copyWith(
                    fontSize: 14, fontWeight: semibold),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                subtitle!,
                style:
                    regularTextStyle.copyWith(fontSize: 11, fontWeight: normal),
              )
            ],
          ),
          Spacer(),
          Icon(Icons.keyboard_arrow_right),
        ],
      ),
    );
  }
}
