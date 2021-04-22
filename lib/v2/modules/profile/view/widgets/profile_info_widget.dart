import 'package:flutter/material.dart';
import 'package:remessa_app/models/hive/customer_model.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/user_avatar_widget.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({
    Key key,
    @required this.customer,
  })  : assert(customer != null),
        super(key: key);

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          UserAvatarWidget(
            userName: customer.name,
            lettersColor: StyleColors.BRAND_PRIMARY_20,
            backgroundColor: StyleColors.BRAND_PRIMARY_50,
            size: 62,
          ),
          SizedBox(height: 8),
          Text(
            customer.name,
            style: TextStyle(
              color: StyleColors.SUPPORT_NEUTRAL_10,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 2),
          Text(
            customer.email,
            style: TextStyle(
              color: StyleColors.BRAND_PRIMARY_20,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
