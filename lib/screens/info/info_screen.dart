import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/models/view_generators/info_model.dart';
import 'package:remessa_app/models/view_model.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/actions/error_action.dart';
import 'package:remessa_app/v2/core/widgets/cached_network_image_widget.dart';
import 'package:remessa_app/v2/core/widgets/gradient_button_widget.dart';
import 'package:screens/safe_area_config.dart';
import 'package:screens/screen_widget.dart';
import 'package:screens/screens.dart';

class InfoScreen extends StatefulWidget implements View<InfoModel> {
  @override
  final InfoModel model;

  InfoScreen({Key key, @required this.model})
      : assert(model != null),
        super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  ScreenWidget screen;

  bool _errorHandler(ActionErrorNotification notification) {
    screen.errorStreamController.add(notification.message);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final action = widget.model.action;

    screen = GetIt.I<Screens>().widget(
      isStatic: true,
      safeAreaConfig: SafeAreaConfig(bottom: false),
      child: NotificationListener<ActionErrorNotification>(
        onNotification: _errorHandler,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: 150,
              child: Container(
                width: 70,
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 85),
                  child: CachedNetworkImageWigdet(
                    imageURL: widget.model.imageURL,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 150),
              width: double.infinity,
              decoration: BoxDecoration(
                color: StyleColors.SUPPORT_NEUTRAL_10,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24) +
                    const EdgeInsets.only(bottom: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 8,
                      ),
                      child: Column(
                        children: [
                          Text(
                            widget.model.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              color: StyleColors.BRAND_PRIMARY_80,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.model.content,
                            style: TextStyle(
                              color: StyleColors.BRAND_SECONDARY_50,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    GradientButtonWidget(
                      label: action.name,
                      onPressed: () => action.action(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return screen;
  }
}
