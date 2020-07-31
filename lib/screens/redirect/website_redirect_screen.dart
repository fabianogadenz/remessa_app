import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/screens/redirect/website_redirect_screen_args.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/gradient_button_widget.dart';
import 'package:screens/screens.dart';
import 'package:url_launcher/url_launcher.dart';

class WebsiteRedirectScreen extends StatelessWidget {
  final i18n = GetIt.I<I18n>();

  WebsiteRedirectScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WebsiteRedirectScreenArgs args = NavigatorHelper.getArgs(context);

    return GetIt.I<Screens>().widget(
      isAccent: true,
      showAppBar: true,
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        height: MediaQuery.of(context).size.height - 150,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset('images/website_redirect.png'),
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
                      ? Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: StyleColors.SUPPORT_WARNING_10
                                    .withOpacity(.4),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    RemessaIcons.timer,
                                    color: StyleColors.SUPPORT_WARNING_60,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          args.note.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                StyleColors.SUPPORT_WARNING_60,
                                          ),
                                        ),
                                        Text(
                                          args.note.description,
                                          style: TextStyle(
                                            color:
                                                StyleColors.SUPPORT_WARNING_60,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                          ],
                        )
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
                  onPressed: () async {
                    TrackEvents.log(TrackEvents.WEBSITE_REDIRECT_CLICK);
                    GetIt.I<NavigatorHelper>().pop();
                    launch(args.url);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
