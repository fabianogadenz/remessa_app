import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/primary_button_widget.dart';

class InitialStepperFooterWidget extends StatelessWidget {
  InitialStepperFooterWidget({
    Key key,
    @required this.length,
    @required this.index,
    this.highlightedButton = false,
    this.onTap,
  }) : super(key: key);

  final i18n = GetIt.I<I18n>();
  final int length;
  final int index;
  final bool highlightedButton;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 24),
            child: Row(
              children: List.generate(
                length,
                (int currentIndex) => Container(
                  decoration: BoxDecoration(
                    color: StyleColors.SUPPORT_NEUTRAL_10
                        .withOpacity(currentIndex == index ? 1 : 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                ),
              ),
            ),
          ),
          Container(
            height: 48,
            margin: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            child: Container(
              child: highlightedButton
                  ? PrimaryButtonWidget(i18n.trans('start'), onPressed: onTap)
                  : GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Text(
                            i18n.trans('next'),
                            style: TextStyle(
                              color: StyleColors.SUPPORT_NEUTRAL_10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                      onTap: () => onTap(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
