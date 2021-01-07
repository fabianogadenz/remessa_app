import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/chat_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';

import 'package:remessa_app/screens/dashboard/dashboard_screen.dart';
import 'package:remessa_app/screens/home/home_screen_store.dart';
// import 'package:remessa_app/screens/loader_screen.dart';
import 'package:remessa_app/screens/transaction_details/transaction_details_screen_args.dart';
// import 'package:remessa_app/stores/info_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:screens/screens.dart';

class TabContent {
  final String label;
  final IconData iconData;
  final Widget widget;
  final Function action;

  TabContent({
    @required this.label,
    @required this.iconData,
    @required this.widget,
    this.action,
  })  : assert(label != null),
        assert(iconData != null),
        assert(widget != null);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final i18n = GetIt.I<I18n>();
  final _homeScreenStore = GetIt.I<HomeScreenStore>()..setErrorMessage(null);
  final _appStore = GetIt.I<AppStore>();
  // final _infoStore = GetIt.I<InfoStore>();
  final navigator = GetIt.I<NavigatorHelper>();

  List<TabContent> _tabs = [];
  ReactionDisposer reactionDisposer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reactionDisposer = autorun(_handleInfoToShow);
    });

    _tabs = <TabContent>[
      TabContent(
        label: i18n.trans('outbound'),
        iconData: RemessaIcons.list,
        widget: DashboardScreen(),
        action: () {
          TrackEvents.log(TrackEvents.NAVBAR_SEND_CLICK);
        },
      ),
      TabContent(
        label: i18n.trans('simulator'),
        iconData: RemessaIcons.send,
        widget: Container(),
        action: () {
          TrackEvents.log(TrackEvents.NAVBAR_SIMULATOR_CLICK);
          navigator.pushNamed(AppRouter.SIMULATOR_ROUTE);
        },
      ),
      // TabContent(
      //   label: 'Perfil',
      //   iconData: RemessaIcons.user_fill,
      //   widget: DashboardScreen(),
      // ),
    ];

    if (_appStore?.configs?.isChatEnabled ?? true) {
      _tabs.add(
        TabContent(
          label: i18n.trans('help'),
          iconData: RemessaIcons.chat,
          widget: Container(),
          action: () {
            TrackEvents.log(TrackEvents.DASHBOARD_HELP_TAB_CLICK);
            ChatHelper().openChat();
          },
        ),
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    reactionDisposer();
    super.dispose();
  }

  _handleInfoToShow(_) async {
    // TODO: Uncomment this code
    // await _infoStore.check();

    // if (_infoStore.hasInfoToShow) {
    //   navigator.pushReplacementNamed(
    //     AppRouter.GENERATED_VIEW_ROUTE,
    //     arguments: _infoStore.info,
    //   );

    //   return;
    // }

    if (_appStore.transactionId != null) {
      if (Navigator.canPop(context)) {
        Navigator.popUntil(context, (route) => route.isFirst);
      }

      navigator.pushNamed(
        AppRouter.TRANSACTION_DETAILS_ROUTE,
        arguments: TransactionDetailsScreenArgs(
          transactionId: _appStore.transactionId,
        ),
      );

      _appStore.setTransactionId(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        // TODO: Uncomment this code
        // if (_infoStore.hasInfoToShow || _infoStore.isLoading) {
        //   return LoaderScreen();
        // }

        return GetIt.I<Screens>().widget(
          isStatic: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          child: _tabs[_homeScreenStore.currentTabIndex].widget,
          bottomNavigationBar: _tabs.length >= 2
              ? BottomNavigationBar(
                  selectedItemColor: StyleColors.SUPPORT_NEUTRAL_10,
                  unselectedItemColor: StyleColors.SUPPORT_NEUTRAL_40,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 100,
                  iconSize: 30,
                  currentIndex: _homeScreenStore.currentTabIndex,
                  onTap: (int index) {
                    onTabTapped(context, index);
                  },
                  items: _tabs
                      .map(
                        (tab) => BottomNavigationBarItem(
                          icon: Icon(
                            tab.iconData,
                            size: 18,
                          ),
                          label: tab.label,
                        ),
                      )
                      .toList(),
                )
              : null,
        )
          ..errorStreamController.add(_homeScreenStore.errorMessage)
          ..loaderStreamController.add(_homeScreenStore.isLoading);
      },
    );
  }

  void onTabTapped(BuildContext context, int index) async {
    if (_tabs[index].action != null) {
      return _tabs[index].action();
    }

    _homeScreenStore.setCurrentTabIndex(index);
  }
}
