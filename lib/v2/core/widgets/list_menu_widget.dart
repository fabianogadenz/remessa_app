import 'package:flutter/material.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';

class MenuItem {
  final Icon icon;
  final String label;
  final Function action;
  final bool hasSuffix;

  MenuItem({
    @required this.icon,
    @required this.label,
    @required this.action,
    this.hasSuffix = true,
  });
}

class ListMenuWidget extends StatelessWidget {
  const ListMenuWidget({
    Key key,
    this.dividerColor,
    @required this.menuItems,
  })  : assert(menuItems != null),
        super(key: key);

  final Color dividerColor;
  final List<MenuItem> menuItems;

  Widget get _divider => Divider(
        color: dividerColor ?? StyleColors.BRAND_PRIMARY_10.withOpacity(.2),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _divider,
        ...menuItems
            .map(
              (item) => item != null
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: item.action,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      alignment: Alignment.center,
                                      child: item.icon,
                                    ),
                                    SizedBox(width: 14),
                                    Text(
                                      item.label,
                                      style: TextStyle(
                                        color: StyleColors.SUPPORT_NEUTRAL_10,
                                      ),
                                    ),
                                  ],
                                ),
                                item.hasSuffix
                                    ? Icon(
                                        RemessaIcons.arrow_right,
                                        color: StyleColors.BRAND_PRIMARY_20,
                                        size: 18,
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          _divider,
                        ],
                      ),
                    )
                  : Container(),
            )
            .toList(),
      ],
    );
  }
}
