import 'package:flutter/material.dart';
import 'package:remessa_app/helpers/name_helper.dart';
import 'package:remessa_app/style/colors.dart';

class UserAvatarWidget extends StatefulWidget {
  const UserAvatarWidget({
    Key key,
    @required this.userName,
    this.isDisabled = false,
    this.backgroundColor,
    this.lettersColor,
  })  : assert(userName != null),
        super(key: key);

  final String userName;
  final bool isDisabled;

  final Color backgroundColor;
  final Color lettersColor;

  @override
  _UserAvatarWidgetState createState() => _UserAvatarWidgetState();
}

class _UserAvatarWidgetState extends State<UserAvatarWidget> {
  Color backgroundColor = StyleColors.BRAND_PRIMARY_40.withOpacity(0.1);
  Color lettersColor = StyleColors.BRAND_PRIMARY_40;

  @override
  void initState() {
    backgroundColor = widget.backgroundColor ?? backgroundColor;
    lettersColor = widget.lettersColor ?? lettersColor;

    if (widget.isDisabled != null && widget.isDisabled) {
      backgroundColor = backgroundColor.withOpacity(.6);
      lettersColor = lettersColor.withOpacity(.6);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      width: 40,
      height: 40,
      child: Center(
        child: Text(
          NameHelper.abbreviation(widget.userName).toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: lettersColor,
          ),
        ),
      ),
    );
  }
}
