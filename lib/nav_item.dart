import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onPressed;
  final bool hidden;
  final bool hasDropDown;
  final bool hideTitles;
  final Widget child;
  final double rightMargin;

  NavItem(
      {this.title,
      this.subTitle,
      this.rightMargin: 10,
      @required this.child,
      this.onPressed,
      this.hideTitles: false,
      this.hidden: false,
      this.hasDropDown: false});

  @override
  Widget build(BuildContext context) {
    return hidden
        ? SizedBox.shrink()
        : InkWell(
            hoverColor: Colors.transparent,
            onTap: onPressed,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                child,
                if (!hideTitles) ...[
                  SizedBox(
                    width: 4,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        title ?? "",
                        style: TextStyle(color: Colors.white60, fontSize: 14),
                      ),
                      if (subTitle != null)
                        Text(
                          subTitle ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.white60),
                        ),
                    ],
                  )
                ],
                if (hasDropDown) ...[
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white60,
                    size: 16,
                  )
                ],
                SizedBox(
                  width: rightMargin,
                )
              ],
            ),
          );
  }
}
