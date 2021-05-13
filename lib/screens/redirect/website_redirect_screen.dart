import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/v2/core/constants/image_contants.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/helpers/uri_helper.dart';
import 'package:remessa_app/screens/redirect/website_redirect_screen_args.dart';
import 'package:remessa_app/screens/redirect/widgets/website_redirect_note_widget.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/app_bar_widget.dart';
import 'package:remessa_app/v2/core/widgets/gradient_button_widget.dart';
import 'package:screens/screens.dart';
import 'package:url_launcher/url_launcher.dart';

class WebsiteRedirectScreen extends StatefulWidget {
  WebsiteRedirectScreen({Key key}) : super(key: key);

  @override
  _WebsiteRedirectScreenState createState() => _WebsiteRedirectScreenState();
}

class _WebsiteRedirectScreenState extends State<WebsiteRedirectScreen> {
  final i18n = GetIt.I<I18n>();
  WebsiteRedirectScreenArgs args;

  @override
  void didChangeDependencies() {
    args = NavigatorHelper.getArgs(context);
    super.didChangeDependencies();
  }

  void redirect() async {
    TrackingEvents.log(TrackingEvents.WEBSITE_REDIRECT_CLICK);
    GetIt.I<NavigatorHelper>().pop();
    launch(UriHelper.addQueryParams(args?.url, args?.utm?.toMap()));
  }

  void _onBackButtonClick() {
    TrackingEvents.log(TrackingEvents.WEBSITE_GO_BACK_CLICK);
  }

  @override
  Widget build(BuildContext context) {
    return GetIt.I<Screens>().widget(
      isAccent: true,
      showAppBar: true,
      statusBarBrightness: Brightness.light,
      appBarWidget: AppBarWidget(
        prevAction: _onBackButtonClick,
        elevation: 0,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        height: MediaQuery.of(context).size.height - 150,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset(ImageConstants.WEBSITE_REDIRECT),
                  Text(
                    args.title ??
                        i18n.trans('website_redirect_screen', ['title']),
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
                    args.description ??
                        i18n.trans('website_redirect_screen',
                            ['description', 'default']),
                    style: TextStyle(
                      color: StyleColors.BRAND_SECONDARY_50,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  args.note != null
                      ? WebsiteRedirectNoteWidget(note: args?.note)
                      : Container(),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width - 60,
                height: 50,
                child: GradientButtonWidget(
                  label: i18n.trans('website_redirect_screen', ['action']),
                  onPressed: redirect,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
