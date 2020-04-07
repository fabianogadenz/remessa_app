import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class InitialStepperFooterWidget extends StatelessWidget {
  const InitialStepperFooterWidget({
    Key key,
    @required this.length,
    @required this.index,
    this.highlightedButton = false,
    this.onTap,
  }) : super(key: key);

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
                  ? RaisedButton(
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 60,
                      ),
                      color: StyleColors.SUPPORT_NEUTRAL_10,
                      onPressed: () => onTap(),
                      child: Text(
                        'Começar',
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: StyleColors.BRAND_PRIMARY_40,
                            ),
                      ),
                    )
                  : GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Próximo',
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
