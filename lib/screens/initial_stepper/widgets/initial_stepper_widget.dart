import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class InitialStepperWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const InitialStepperWidget({
    Key key,
    @required this.imagePath,
    @required this.title,
    @required this.description,
  })  : assert(imagePath != null),
        assert(title != null),
        assert(description != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Image.asset(
            imagePath,
            height: 360,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: StyleColors.SUPPORT_NEUTRAL_10,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: StyleColors.SUPPORT_NEUTRAL_10,
                ),
              ),
            ),
          ],
        ),
        // SafeArea
        SizedBox(
          height: 70,
        ),
      ],
    );
  }
}
