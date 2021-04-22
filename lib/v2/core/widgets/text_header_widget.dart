import 'package:flutter/material.dart';

class TextHeaderWidget extends StatelessWidget {
  const TextHeaderWidget({
    Key key,
    @required this.label,
  })  : assert(label != null),
        super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 23,
        right: 23,
        top: 30,
        bottom: 40,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 32),
      ),
    );
  }
}
