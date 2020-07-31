import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key key,
    @required this.title,
    @required this.description,
    this.icon,
  })  : assert(title != null),
        assert(description != null),
        super(key: key);

  final String title;
  final String description;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: StyleColors.BRAND_PRIMARY_60,
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  icon ??
                      Icon(
                        Icons.attach_money,
                        size: 20,
                      ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: StyleColors.SUPPORT_NEUTRAL_10,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: StyleColors.BRAND_PRIMARY_50,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.close,
                      color: StyleColors.SUPPORT_NEUTRAL_10,
                      size: 18,
                    ),
                  ),
                  onTap: () => Navigator.pop(context))
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: StyleColors.SUPPORT_NEUTRAL_10,
              ),
            ),
          )
        ],
      ),
    );
  }
}
