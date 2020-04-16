import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:remessa_app/style/colors.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;
  final bool previousStatusBarWhiteForeground;
  final Function closeFunction;

  ErrorDialog({
    Key key,
    @required this.errorMessage,
    this.previousStatusBarWhiteForeground,
    @required this.closeFunction,
  })  : assert(errorMessage != null && errorMessage.isNotEmpty),
        assert(closeFunction != null),
        super(key: key);

  _closeDialog() {
    if (previousStatusBarWhiteForeground != null) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }

    closeFunction();
  }

  @override
  Widget build(BuildContext context) {
    if (errorMessage == null) return Container();

    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    return Container(
      color: StyleColors.SUPPORT_DANGER_40,
      child: SafeArea(
        child: Material(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: StyleColors.SUPPORT_DANGER_40,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.warning),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      errorMessage,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: _closeDialog,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
