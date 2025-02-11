// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final Color? backgroundColor;
  final bool hideBack;
  const BasicAppbar({
    super.key,
    this.hideBack = false,
    this.action,
    this.title,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      title: title ?? const Text(''),
      actions: [
        action ?? Container(),
      ],
      centerTitle: true,
      leading: hideBack
          ? null
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.03)
                      : Colors.black.withOpacity(0.03),
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                  size: 15,
                ),
              ),
            ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
