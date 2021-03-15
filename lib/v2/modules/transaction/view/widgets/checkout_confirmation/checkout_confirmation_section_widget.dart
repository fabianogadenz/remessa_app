import 'package:flutter/material.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;
import 'package:remessa_app/v2/core/widgets/gradient_button_widget.dart';

class CheckoutConfirmationSectionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final String value;
  final ac.Action linkAction;
  final ac.Action action;

  const CheckoutConfirmationSectionWidget({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.subTitle,
    this.value,
    this.linkAction,
    this.action,
  })  : assert(icon != null),
        assert(title != null),
        assert(subTitle != null),
        super(key: key);

  bool get _hasAction => action != null;

  _handleValue() => value != null
      ? Column(
          children: [
            SizedBox(
              height: 2,
            ),
            Text(
              value,
              style: TextStyle(
                color: StyleColors.BRAND_SECONDARY_40,
                fontSize: 12,
              ),
            ),
          ],
        )
      : Container();

  _handleLinkAction() => linkAction != null
      ? Column(
          children: [
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: linkAction.action,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    linkAction.name,
                    style: TextStyle(
                      color: StyleColors.BRAND_PRIMARY_40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Icon(
                    RemessaIcons.arrow_right,
                    color: StyleColors.BRAND_PRIMARY_40,
                    size: 10,
                  ),
                ],
              ),
            ),
          ],
        )
      : Container();

  _handleAction() => _hasAction
      ? Column(
          children: [
            SizedBox(
              height: 24,
            ),
            GradientButtonWidget(
              label: action.name,
              hasShadow: true,
              onPressed: action.action,
            ),
          ],
        )
      : Container();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: _hasAction
            ? null
            : Border(
                bottom: BorderSide(
                  color: StyleColors.SUPPORT_NEUTRAL_30,
                ),
              ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: StyleColors.BRAND_PRIMARY_40.withOpacity(.15),
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(
                  icon,
                  color: StyleColors.BRAND_PRIMARY_40,
                  size: 15,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: StyleColors.BRAND_SECONDARY_60,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(
                        color: StyleColors.BRAND_SECONDARY_50,
                      ),
                    ),
                    _handleValue(),
                    _handleLinkAction(),
                  ],
                ),
              ),
            ],
          ),
          _handleAction(),
        ],
      ),
    );
  }
}
