import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class EmptyCardWidget extends StatelessWidget {
  const EmptyCardWidget({
    Key key,
    @required this.image,
    @required this.text,
    this.margin,
    this.action,
  })  : assert(image != null),
        assert(text != null),
        super(key: key);

  final Image image;
  final String text;
  final EdgeInsets margin;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    final _actionSection = [];
    if (action != null) {
      _actionSection.addAll([
        SizedBox(
          height: 16,
        ),
        action,
      ]);
    }

    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: StyleColors.BRAND_PRIMARY_50,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image,
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 15),
                  ),
                ),
              )
            ],
          ),
          ..._actionSection,
        ],
      ),
    );
  }
}
