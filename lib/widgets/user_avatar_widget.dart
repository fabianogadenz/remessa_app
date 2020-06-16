import 'package:flutter/material.dart';
import 'package:remessa_app/helpers/name_helper.dart';
import 'package:remessa_app/style/colors.dart';

class UserAvatarWidget extends StatefulWidget {
  const UserAvatarWidget({
    Key key,
    @required this.userName,
    this.isDisabled = false,
  })  : assert(userName != null),
        super(key: key);

  final String userName;
  final bool isDisabled;

  @override
  _UserAvatarWidgetState createState() => _UserAvatarWidgetState();
}

class _UserAvatarWidgetState extends State<UserAvatarWidget> {
  Color avatarBackgroundColor = StyleColors.BRAND_PRIMARY_40.withOpacity(0.1);
  Color avatarLettersColor = StyleColors.BRAND_PRIMARY_40;

  @override
  void initState() {
    if (widget.isDisabled != null && widget.isDisabled) {
      avatarBackgroundColor = StyleColors.BRAND_SECONDARY_10.withOpacity(0.4);
      avatarLettersColor = StyleColors.BRAND_SECONDARY_40;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: avatarBackgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      width: 40,
      height: 40,
      child: Center(
        child: Text(
          NameHelper.abbreviation(widget.userName).toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: avatarLettersColor,
          ),
        ),
      ),
    );
  }
}
