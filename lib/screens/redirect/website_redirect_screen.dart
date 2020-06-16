import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/gradient_button_widget.dart';
import 'package:screens/screens.dart';
import 'package:url_launcher/url_launcher.dart';

class WebsiteRedirectScreen extends StatelessWidget {
  final String url;
  final String title;
  final String description;
  final i18n = GetIt.I<I18n>();

  WebsiteRedirectScreen({
    Key key,
    @required this.url,
    this.title,
    this.description,
  })  : assert(url != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetIt.I<Screens>().widget(
      isAccent: true,
      showAppBar: true,
      isStatic: true,
      statusBarBrightness: Brightness.light,
      appBarWidget: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              TrackEvents.log(TrackEvents.WEBSITE_GO_BACK_CLICK);
              GetIt.I<NavigatorHelper>().pop();
            }),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Image.asset('images/website_redirect.png'),
              SizedBox(
                height: 20,
              ),
              Text(
                title ?? i18n.trans('website_redirect_screen', ['title']),
                style: TextStyle(
                  color: StyleColors.BRAND_PRIMARY_80,
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                description ??
                    i18n.trans(
                        'website_redirect_screen', ['description', 'default']),
                style: TextStyle(
                  color: StyleColors.BRAND_SECONDARY_50,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: GradientButtonWidget(
              label: i18n.trans('website_redirect_screen', ['action']),
              onPressed: () async {
                TrackEvents.log(TrackEvents.WEBSITE_REDIRECT_CLICK);
                GetIt.I<NavigatorHelper>().pop();
                launch(url);
              },
            ),
          ),
        ],
      ),
    );
  }
}
